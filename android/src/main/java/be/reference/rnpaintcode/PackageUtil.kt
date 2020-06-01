package be.reference.rnpaintcode

import kotlin.reflect.KClass

object PackageUtil {

    var packageName: String = ""

    fun getPaintCodeClass(): KClass<out Any> {
        return Class.forName("$packageName.PaintCode").kotlin
    }

    fun getPaintCodeResizingBehaviour(forName: String): Any {
        val clazz = getPaintCodeClass().nestedClasses.first { it.simpleName == "ResizingBehavior" }
        val enumConstants = clazz.java.enumConstants
        return enumConstants.first { it.toString().equals(forName, true) }
    }
}