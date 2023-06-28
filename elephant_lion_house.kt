import java.io.File
import kotlin.system.exitProcess

//Global Variables
val freshStart = "The Fresh Start Initiative"
val startGoal = "To support people in creating a fresh start and positive outlook on life"
val freshStartFileName = "freshstart.txt"

//Functions
fun createFreshStartFile(): Unit {
    val freshStartFile = File(freshStartFileName)
    if (freshStartFile.exists()) {
        println("The file $freshStartFileName already exists")
        exitProcess(1)
    } else {
        freshStartFile.createNewFile()
    }
    println("Created new file for Fresh Start Initiative")
}

fun writeToFreshStartFile(): Unit {
    val freshStartFile = File(freshStartFileName)
    freshStartFile.appendText("# $freshStart\r\n")
    freshStartFile.appendText("$startGoal\r\n\r\n")

    val tips = arrayOf("Start each day with positive affirmations", "Surround yourself with supportive people",
            "Focus on the present moment", "Make changes to improve your life", "Forgive yourself and move on",
            "Learn to accept the things you cannot change", "Celebrate small wins",
            "Take time to relax and take care of yourself")

    freshStartFile.appendText("## Tips for Creating Your Fresh Start\r\n")
    for (tip in tips) {
        freshStartFile.appendText("- $tip\r\n")
    }
    println("Wrote tips to file for Fresh Start Initiative")
}

fun main(args: Array<String>) {
    createFreshStartFile()
    writeToFreshStartFile()
}