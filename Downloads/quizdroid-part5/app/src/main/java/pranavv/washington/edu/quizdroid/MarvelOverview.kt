package pranavv.washington.edu.quizdroid

import android.content.Intent
import android.os.Bundle
import android.os.PersistableBundle
import android.support.v7.app.AppCompatActivity
import android.view.View

class MarvelOverview : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.marvel_overview)

        val mathBegin = findViewById<View>(R.id.marvel_start)
        mathBegin.setOnClickListener(){
            val intent = Intent(this, marvelQuestionOne::class.java)
            startActivity(intent)
        }
    }
}