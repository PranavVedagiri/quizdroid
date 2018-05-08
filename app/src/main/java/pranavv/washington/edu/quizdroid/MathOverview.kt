package pranavv.washington.edu.quizdroid

import android.content.Intent
import android.os.Bundle
import android.os.PersistableBundle
import android.support.v7.app.AppCompatActivity
import android.view.View

class MathOverview : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.math_overview)

        val mathBegin = findViewById<View>(R.id.math_start)
        mathBegin.setOnClickListener(){
            val intent = Intent(this, mathQuestionOne::class.java)
            startActivity(intent)
        }
    }
}