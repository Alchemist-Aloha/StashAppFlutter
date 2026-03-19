package com.github.damontecres.stash_app_flutter

import android.app.PictureInPictureParams
import android.os.Build
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
	private val pipChannel = "stash_app_flutter/pip"

	override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
		super.configureFlutterEngine(flutterEngine)

		MethodChannel(flutterEngine.dartExecutor.binaryMessenger, pipChannel)
			.setMethodCallHandler { call, result ->
				when (call.method) {
					"enterPictureInPicture" -> result.success(enterPipMode())
					else -> result.notImplemented()
				}
			}
	}

	private fun enterPipMode(): Boolean {
		if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) {
			return false
		}
		return try {
			val params = PictureInPictureParams.Builder().build()
			enterPictureInPictureMode(params)
		} catch (_: Throwable) {
			false
		}
	}
}
