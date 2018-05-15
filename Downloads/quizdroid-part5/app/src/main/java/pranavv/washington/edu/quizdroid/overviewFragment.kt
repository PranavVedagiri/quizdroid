package pranavv.washington.edu.quizdroid

import android.app.Fragment
import android.content.Intent
import android.os.Bundle
import android.os.PersistableBundle
import android.support.v7.app.AppCompatActivity
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.ListView
import android.widget.TextView


class overviewFragment : Fragment() {

    override fun onCreateView(inflater: LayoutInflater?, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        val inflate = inflater?.inflate(R.layout.fragment_overview, container, false)  as View
        val description = arguments!!.getString("description")
        val questions = arguments!!.getStringArray("questions")
        val answers = arguments!!.getStringArray("answers")
        val d = inflate.findViewById(R.id.description) as TextView
        d.setText(description)

        val begin = inflate.findViewById<Button>(R.id.begin)

        begin.setOnClickListener{
            val transaction = fragmentManager.beginTransaction()
            val bundle = Bundle()
            bundle.putInt("correct", 0)
            bundle.putInt("questionNum", 0)
            bundle.putInt("starting", 0)
            bundle.putInt("total", 2)
            bundle.putStringArray("questions", questions)
            bundle.putStringArray("answers", answers)
            val question = questionFragment()

            question.arguments = bundle

            transaction.replace(R.id.fragments, question).commit()
        }
        return inflate
    }
}
