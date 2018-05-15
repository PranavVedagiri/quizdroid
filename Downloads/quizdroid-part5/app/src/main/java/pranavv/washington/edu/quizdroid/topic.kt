package pranavv.washington.edu.quizdroid

import android.os.Bundle
import android.support.v7.app.AppCompatActivity

class topic : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.topic)
        val top = intent.getStringExtra("topic")
        val desc = intent.getStringExtra("description")
        val questions = intent.getStringArrayExtra("questions")
        val answers = intent.getStringArrayExtra("answers")

        val transaction = fragmentManager.beginTransaction()
        val bundle = Bundle()

        bundle.putString("topic", top)
        bundle.putString("description", desc)
        bundle.putStringArray("questions", questions)
        bundle.putStringArray("answers", answers)

        val overFrag = overviewFragment()
        overFrag.arguments = bundle

        transaction.add(R.id.fragments, overFrag).commit()


    }
}