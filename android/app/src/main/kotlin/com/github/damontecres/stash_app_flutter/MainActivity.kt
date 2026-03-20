package com.github.damontecres.stash_app_flutter

import android.graphics.Rect
import android.app.PictureInPictureParams
import android.os.Build
import android.util.Rational
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
					"enterPictureInPicture" -> {
						val ratioArg = call.argument<Number>("aspectRatio")?.toDouble()
						result.success(enterPipMode(ratioArg))
					}
					else -> result.notImplemented()
				}
			}
	}

	private fun enterPipMode(aspectRatio: Double?): Boolean {
		if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) {
			return false
		}
		return try {
			val paramsBuilder = PictureInPictureParams.Builder()

			if (aspectRatio != null && aspectRatio.isFinite() && aspectRatio > 0.0) {
				// Android PiP expects a limited range close to phone/tablet window shapes.
				val clamped = aspectRatio.coerceIn(0.41841, 2.39)
				val denominator = 1000
				val numerator = (clamped * denominator).toInt().coerceAtLeast(1)
				paramsBuilder.setAspectRatio(Rational(numerator, denominator))
			}

			val visibleRect = Rect()
			val decorView = window?.decorView
			if (decorView != null && decorView.getGlobalVisibleRect(visibleRect) && !visibleRect.isEmpty) {
				paramsBuilder.setSourceRectHint(visibleRect)
			}

			if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
				paramsBuilder.setAutoEnterEnabled(true)
			}

			val params = paramsBuilder.build()
			enterPictureInPictureMode(params)
		} catch (_: Throwable) {
			false
		}
	}
}
