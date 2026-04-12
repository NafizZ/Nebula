package com.nebula.nebula

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "nebula_nano_ai"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->

            if (call.method == "analyze") {

                val text = call.argument<String>("text") ?: ""

                val response = runGeminiNano(text)

                result.success(response)
            } else {
                result.notImplemented()
            }
        }
    }

    // 🤖 MOCK AI (replace with Gemini Nano later)
    private fun runGeminiNano(text: String): String {
        return """
        {
          "summary": "This document contains important information.",
          "dates": ["2026-04-12"],
          "actions": ["Review document", "Create reminder"]
        }
        """.trimIndent()
    }
}