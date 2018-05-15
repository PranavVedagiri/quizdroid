package pranavv.washington.edu.quizdroid

import android.support.v7.widget.DialogTitle

interface TopicRepository{
    fun getTopics(): ArrayList<Top>

    fun getTopic(index: Int): Top
}