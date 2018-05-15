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
import android.widget.RadioButton
import android.widget.RadioGroup
import android.widget.TextView


class questionFragment : Fragment() {


    override fun onCreateView(inflater: LayoutInflater?, container: ViewGroup?, savedInstanceState: Bundle?): View {
        val view = inflater?.inflate(R.layout.fragment_question, container, false) as View

        val question = view.findViewById<TextView>(R.id.question)
        val radioG = view.findViewById<RadioGroup>(R.id.radioGroup)
        val answerOne = view.findViewById<RadioButton>(R.id.answerOne)
        val answerTwo = view.findViewById<RadioButton>(R.id.answerTwo)
        val answerThree = view.findViewById<RadioButton>(R.id.answerThree)
        val answerFour = view.findViewById<RadioButton>(R.id.answerFour)

        val submit = view.findViewById<Button>(R.id.submit)

        submit.isEnabled = false
        radioG.setOnCheckedChangeListener { _, _ ->
            submit.isEnabled = true
        }

        var questions = arguments!!.getStringArray("questions")
        var correct = arguments!!.getInt("correct")
        var questionNum = arguments!!.getInt("questionNum")
        var total = arguments!!.getInt("total")
        var answers = arguments!!.getStringArray("answers")
        var starting = arguments!!.getInt("starting")

        question.setText(questions[questionNum])
        answerOne.setText(answers[starting])
        answerTwo.setText(answers[starting + 1])
        answerThree.setText(answers[starting + 2])
        answerFour.setText(answers[starting + 3])

        submit.setOnClickListener{
            val selectedAnswer = view.findViewById<RadioButton>(radioG.checkedRadioButtonId).getText().toString()
            val answer = answers[starting]
            if(selectedAnswer == answer) correct = correct + 1
            val numCorrect = correct

            val transaction = fragmentManager.beginTransaction()
            val bundle = Bundle()
            bundle.putStringArray("questions", questions)
            bundle.putInt("correct", numCorrect)
            bundle.putInt("questionNum", questionNum + 1)
            bundle.putInt("total", total)
            bundle.putStringArray("answers", answers)
            bundle.putInt("starting", starting + 4)
            bundle.putString("selectedAnswer", selectedAnswer)
            bundle.putString("answer", answer)

            val answerFrag = answerFragment()
            answerFrag.arguments = bundle
            transaction.replace(R.id.fragments, answerFrag).commit()
        }


        return view
    }

}