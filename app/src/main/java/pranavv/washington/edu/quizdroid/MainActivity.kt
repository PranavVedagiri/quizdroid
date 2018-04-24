package pranavv.washington.edu.quizdroid

import android.content.Intent
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.util.Log
import android.view.View
import android.widget.Button
import android.widget.TextView

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val math = findViewById<Button>(R.id.math) as Button
        val physics = findViewById<Button>(R.id.physics) as Button
        val marvel = findViewById<Button>(R.id.marvel) as Button

        math.setOnClickListener {
            val intent = Intent(this, MathOverview::class.java)
            startActivity(intent)
        }

        physics.setOnClickListener{
            val intent = Intent(this, PhysicsOverview::class.java)
            startActivity(intent)
        }

        marvel.setOnClickListener{
            val intent = Intent(this, MarvelOverview::class.java)
            startActivity(intent)
        }


    }


}
