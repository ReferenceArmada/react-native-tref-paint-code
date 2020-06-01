package be.reference.rnpaintcode

import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import kotlin.reflect.full.memberProperties


class TrefPaintCodeHelper(reactContext: ReactApplicationContext?) : ReactContextBaseJavaModule(reactContext!!) {

    override fun getName(): String {
        return "TrefPaintCodeHelper"
    }

    private fun getHex(colorString: String): String {
        val intColor = colorString.toInt()
        return java.lang.String.format("#%06X", 0xFFFFFF and intColor)
    }

    private fun getColors(): MutableMap<String, String> {
        val colors: MutableMap<String, String> = HashMap()

        val clazz = PackageUtil.getPaintCodeClass()

        val members = clazz.memberProperties
        val instance = clazz.objectInstance

        for (member in members) {
            val name = member.name
            val value = member.getter.call(instance).toString()

            colors[name] = getHex(value)
        }

        return colors
    }

    override fun getConstants(): MutableMap<String, Any> {
        val constants: MutableMap<String, Any> = HashMap()
        constants["Colors"] = getColors()
        return constants
    }

}