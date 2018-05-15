package pranavv.washington.edu.quizdroid

import android.content.Intent
import android.os.Bundle
import android.os.PersistableBundle
import android.support.v7.app.AppCompatActivity
import android.view.View

class PhysicsOverview : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.physics_overview)

        val mathBegin = findViewById<View>(R.id.physics_start)
        mathBegin.setOnClickListener(){
            val intent = Intent(this, physicsQuestionOne::class.java)
            startActivity(intent)
        }
    }
}