package be.reference.rnpaintcode

import android.view.View
import android.widget.Toast
import com.facebook.react.bridge.ReadableMap
import com.facebook.react.uimanager.SimpleViewManager
import com.facebook.react.uimanager.ThemedReactContext
import com.facebook.react.uimanager.annotations.ReactProp


class TrefPaintCodeManager : SimpleViewManager<View?>() {
    override fun getName(): String {
        return REACT_CLASS
    }

    public override fun createViewInstance(c: ThemedReactContext): View {
        return DrawableView(c)
    }

    @ReactProp(name = "method")
    fun setMethod(view: DrawableView, method: String?) {
        view.setMethodName(method)
    }

    @ReactProp(name = "params")
    fun setParams(view: DrawableView, params: ReadableMap?) {
        view.setParams(params)
    }

    companion object {
        const val REACT_CLASS = "TrefPaintCode"
    }
}