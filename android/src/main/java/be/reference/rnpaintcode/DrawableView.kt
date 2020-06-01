package be.reference.rnpaintcode

import android.content.Context
import android.graphics.Canvas
import android.graphics.RectF
import android.util.AttributeSet
import android.util.Log
import android.view.View
import com.facebook.react.bridge.ReadableMap
import java.util.*
import kotlin.collections.ArrayList
import kotlin.reflect.KParameter
import kotlin.reflect.full.memberFunctions

class DrawableView : View {
    private val tag = javaClass.simpleName
    private var params: ReadableMap? = null
    private var methodName: String? = null
    private val map: MutableMap<String, Any?> = HashMap()
    private val frame = RectF()

    constructor(context: Context?) : super(context)
    constructor(context: Context?, attrs: AttributeSet?) : super(context, attrs)
    constructor(context: Context?, attrs: AttributeSet?, defStyleAttr: Int) : super(context, attrs, defStyleAttr)

    fun setMethodName(methodName: String?) {
        this.methodName = methodName
    }

    fun setParams(params: ReadableMap?) {
        this.params = params
    }

    private fun prepareMap() {
        val iterator = params!!.entryIterator
        while (iterator.hasNext()) {
            val rootEntry = iterator.next()
            val innerObject = rootEntry.value as ReadableMap

            try {
                when (innerObject.getString("type")) {
                    "string" -> map[rootEntry.key] = innerObject.getString("value")
                    "boolean" -> map[rootEntry.key] = innerObject.getBoolean("value")
                    "double" -> map[rootEntry.key] = innerObject.getDouble("value")
                    "float" -> map[rootEntry.key] = innerObject.getDouble("value").toFloat()
                    "resizingBehaviour" -> map[rootEntry.key] = mapResizingBehaviour(innerObject.getString("value")!!)
                }
            } catch (ex: Exception) {
                Log.e(tag, "Parameter cast error occurred: " + ex.localizedMessage)
            }
        }
    }

    private fun mapResizingBehaviour(value: String): Any {
        return PackageUtil.getPaintCodeResizingBehaviour(value)
    }

    private fun prepareArgs(c: Canvas, f: RectF, params: List<KParameter>): ArrayList<Any?> {
        val list = ArrayList<Any?>()
        val objInstance = PackageUtil.getPaintCodeClass().objectInstance

        list.add(objInstance)

        for (param in params) {
            val paramName = param.name
            if (paramName != null && paramName != "null") {
                when (paramName) {
                    "canvas" -> {
                        list.add(c)
                    }
                    "frame", "targetFrame" -> {
                        list.add(f)
                    }
                    "context" -> {
                        list.add(context)
                    }
                    else -> {
                        list.add(map[paramName])
                    }
                }
            }
        }

        return list
    }

    private fun calculateMethodParameterCount(params: List<KParameter>): Int {
        var paramCount = params.count()
        for (param in params) {
            when(param.name) {
                "canvas", "frame", "targetFrame", "null", null, "context" -> {
                    paramCount -= 1
                }
            }
        }
        return paramCount
    }

    private fun invokeDrawMethod(c: Canvas, f: RectF) {

        prepareMap()

        val clazz = PackageUtil.getPaintCodeClass()
        val methods = clazz.memberFunctions

        for (m in methods) {
            val methodParameters = m.parameters
            if (methodName == m.name && map.size == calculateMethodParameterCount(methodParameters)) {

                try {
                    val args = prepareArgs(c, f, methodParameters)

                    Log.e(tag, args.toString())

                    m.call(*args.toArray())
                } catch (e: Exception) {
                    Log.e(tag, e.localizedMessage)
                }
                break
            }
        }
    }

    override fun onDraw(canvas: Canvas) {
        frame[0f, 0f, width.toFloat()] = height.toFloat()
        if (methodName != null && params != null) {
            handler.run {
                invokeDrawMethod(canvas, frame)
            }
        }
        super.onDraw(canvas)
    }
}