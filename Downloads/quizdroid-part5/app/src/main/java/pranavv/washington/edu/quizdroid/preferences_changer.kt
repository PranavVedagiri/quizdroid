package pranavv.washington.edu.quizdroid

import android.Manifest
import android.app.AlarmManager
import android.app.DownloadManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.PackageManager
import android.net.ConnectivityManager
import android.net.Uri
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.os.Environment
import android.os.SystemClock
import android.provider.Settings
import android.support.v4.app.ActivityCompat
import android.support.v4.content.ContextCompat
import android.telephony.SmsManager
import android.text.Editable
import android.text.TextWatcher
import android.util.Log
import android.widget.Button
import android.widget.EditText
import android.widget.Toast
import org.json.JSONArray
import java.io.BufferedInputStream
import java.net.HttpURLConnection
import java.net.URL

class preferences_changer: AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.preferences)
        val start = findViewById(R.id.start) as Button
        val back = findViewById(R.id.back) as Button
        val url = findViewById(R.id.url) as EditText
        val time = findViewById(R.id.time) as EditText

        var savedURL: String = "https://raw.githubusercontent.com/PranavVedagiri/quizdroid_json/master/quizdroid.json"
        var savedTime = 1

        url.addTextChangedListener(object : TextWatcher{
            override fun afterTextChanged(s: Editable?) {
                savedURL = s.toString()
            }

            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {
            }

            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {

            }
        })

        time.addTextChangedListener(object : TextWatcher{
            override fun afterTextChanged(s: Editable?) {
                savedTime = s.toString().toInt()
            }

            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {
            }

            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
            }
        })

        url.setText(savedURL)
        time.setText(savedTime.toString())
        val cm = getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager

        start.setOnClickListener() {
            if (ContextCompat.checkSelfPermission(this, Manifest.permission.WRITE_EXTERNAL_STORAGE)
                    != PackageManager.PERMISSION_GRANTED) {
                Log.i("Preferences", "Permission check")
                ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.WRITE_EXTERNAL_STORAGE), 0)
            }
            if (Settings.Global.getInt(this.contentResolver, Settings.Global.AIRPLANE_MODE_ON, 0) != 0) {
                Toast.makeText(applicationContext, "Sorry you're in airplane mode", Toast.LENGTH_SHORT).show()
            } else if (!cm.activeNetworkInfo.isConnected) {
                Toast.makeText(applicationContext, "Sorry you don't have internet", Toast.LENGTH_SHORT).show()
            } else {
                val alarmIntent = Intent(this, AlarmReceiver::class.java)
                alarmIntent.putExtra("time", savedTime)
                alarmIntent.putExtra("url", savedURL)
                val pendingIntent = PendingIntent.getBroadcast(this, 0, alarmIntent, PendingIntent.FLAG_UPDATE_CURRENT)
                //val intentFilter = IntentFilter("pranavv.washington.edu.quizdroid")
                //registerReceiver(AlarmReceiver(), intentFilter)
                val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager


                if (start.text.toString() == "Start") {
                    alarmManager.setRepeating(AlarmManager.ELAPSED_REALTIME_WAKEUP, SystemClock.elapsedRealtime() + savedTime.toLong() * (60 * 1000), savedTime.toLong() * (60 * 1000), pendingIntent)
                    Toast.makeText(this, "Downloading " + url.text, Toast.LENGTH_SHORT).show()
                    start.setText("Stop")
                    //val intent = Intent(this, TopicRepoClass::class.java)
                    //intent.putExtra("URL", savedURL)
                    //startActivity(intent)
                } else {
                    start.setText("Start")
                }
            }
        }


        back.setOnClickListener {
            val intent = Intent(this, MainActivity::class.java)
            startActivity(intent)
        }

    }

}

class AlarmReceiver: BroadcastReceiver(){

    override fun onReceive(context: Context?, intent: Intent?) {
        val url = intent!!.getStringExtra("url")
        Log.i("Tag", "Downloading from " + url)
        val request = DownloadManager.Request(Uri.parse(url))
        val downloadManager = context!!.getSystemService(Context.DOWNLOAD_SERVICE) as DownloadManager
        request.setTitle("questions.json")
        request.setDescription("JSON File with questions")
        request.setDestinationInExternalPublicDir(Environment.DIRECTORY_DOWNLOADS, "questions.json")
        request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE)
        downloadManager.enqueue(request)
    }



}


