package com.example.tracker

import android.Manifest
import android.content.*
import android.content.pm.PackageManager
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.google.android.gms.maps.*
import com.google.android.gms.maps.model.*

class MapsActivity : AppCompatActivity(), OnMapReadyCallback {

    private lateinit var mMap: GoogleMap
    private var polyline: Polyline? = null
    private val LOCATION_PERMISSION_CODE = 1
    private lateinit var receiver: BroadcastReceiver

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_maps)

        val mapFragment = supportFragmentManager
            .findFragmentById(R.id.map) as SupportMapFragment
        mapFragment.getMapAsync(this)

        requestPermissions()

        receiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context?, intent: Intent?) {
                val lat = intent?.getDoubleExtra("lat", 0.0) ?: return
                val lng = intent.getDoubleExtra("lng", 0.0)
                val point = LatLng(lat, lng)
                updatePolyline(point)
                mMap.animateCamera(CameraUpdateFactory.newLatLngZoom(point, 17f))
            }
        }

        registerReceiver(receiver, IntentFilter("LOCATION_UPDATE"))
    }

    override fun onMapReady(googleMap: GoogleMap) {
        mMap = googleMap
        startService()
    }

    private fun updatePolyline(point: LatLng) {
        if (polyline == null) {
            polyline = mMap.addPolyline(PolylineOptions().add(point).width(10f))
        } else {
            val points = polyline!!.points
            points.add(point)
            polyline!!.points = points
        }
    }

    private fun startService() {
        val intent = Intent(this, LocationService::class.java)
        ContextCompat.startForegroundService(this, intent)
    }

    private fun requestPermissions() {
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION)
            != PackageManager.PERMISSION_GRANTED
        ) {
            ActivityCompat.requestPermissions(
                this,
                arrayOf(Manifest.permission.ACCESS_FINE_LOCATION),
                LOCATION_PERMISSION_CODE
            )
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        unregisterReceiver(receiver)
    }
}
