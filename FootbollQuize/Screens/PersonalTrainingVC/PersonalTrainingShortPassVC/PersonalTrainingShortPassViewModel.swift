import UIKit

struct PersonalTrainingShortPassModel {
    let title: String
    let steps: [String]
}

class PersonalTrainingShortPassViewModel {
    
    let model: [PersonalTrainingShortPassModel] = [
        // 1. Standing Ball Control
        PersonalTrainingShortPassModel(
            title: "Standing Ball Control",
            steps: [
                "Stand straight, feet shoulder-width apart.",
                "Toss the ball up with your foot and catch it back.",
                "Use both feet alternately.",
                "Control the movement effortlessly.",
                "Take a short rest and breathe."
            ]
        ),
        // 2. Short Distance Passing
        PersonalTrainingShortPassModel(
            title: "Short Distance Passing",
            steps: [
                "Find a free space.",
                "Kick the ball against a wall or pass to a partner.",
                "Control accuracy and direction.",
                "The kick should be light.",
                "Repeat 10–15 times with each foot."
            ]
        ),
        // 3. Shooting Without Power
        PersonalTrainingShortPassModel(
            title: "Shooting Without Power",
            steps: [
                "Place the ball on the ground.",
                "Take one step back.",
                "Strike the center of the ball with the inside of your foot.",
                "Control the direction, not the power.",
                "Repeat 5 times with each foot."
            ]
        ),
        // 4. Ball Reception
        PersonalTrainingShortPassModel(
            title: "Ball Reception",
            steps: [
                "Partner passes the ball or rebound it off a wall.",
                "Stop the ball with the sole of your foot.",
                "Move it towards yourself.",
                "Practice receiving with both feet.",
                "Pause after 10 receptions."
            ]
        ),
        // 5. Moving with the Ball
        PersonalTrainingShortPassModel(
            title: "Moving with the Ball",
            steps: [
                "Dribble the ball forward 5 meters.",
                "Turn around and return.",
                "Use both feet.",
                "Change your movement speed.",
                "Repeat 5–7 times."
            ]
        ),
        // 6. "Snake" Exercise
        PersonalTrainingShortPassModel(
            title: "\"Snake\" Exercise",
            steps: [
                "Place 5 objects in a line (bottles, cones).",
                "Dribble the ball between them.",
                "Do not rush — control is key.",
                "Complete 5 runs.",
                "Rest for 1 minute."
            ]
        ),
        // 7. Stationary Dribbling
        PersonalTrainingShortPassModel(
            title: "Stationary Dribbling",
            steps: [
                "Dribble the ball without moving forward.",
                "Use the inside of your foot.",
                "The ball should move easily.",
                "Change the tempo.",
                "Rest for 30 seconds."
            ]
        ),
        // 8. Two-Foot Control
        PersonalTrainingShortPassModel(
            title: "Two-Foot Control",
            steps: [
                "Pass the ball between your feet forward and backward.",
                "Maintain your balance.",
                "Add light touches with the inside of your foot.",
                "10 repetitions for each foot.",
                "Take a short rest."
            ]
        ),
        // 9. Ball Transfers
        PersonalTrainingShortPassModel(
            title: "Ball Transfers",
            steps: [
                "Move the ball left and right between your feet.",
                "Touch it with the sole of your foot.",
                "Control the movement.",
                "Repeat 20–30 times.",
                "Rest and recover your breath."
            ]
        ),
        // 10. Coordination Without Ball
        PersonalTrainingShortPassModel(
            title: "Coordination Without Ball",
            steps: [
                "Quickly move your feet in place.",
                "Keep arms bent at 90 degrees.",
                "Change tempo — 20 seconds fast, 20 seconds slow.",
                "Repeat 3 cycles.",
                "Keep breathing calm."
            ]
        ),
        // 11. Single Leg Balance
        PersonalTrainingShortPassModel(
            title: "Single Leg Balance",
            steps: [
                "Stand on one leg.",
                "Lift the other leg slightly forward.",
                "Hold balance for 30 seconds.",
                "Switch legs.",
                "Repeat 3 sets."
            ]
        ),
        // 12. Turns with Ball
        PersonalTrainingShortPassModel(
            title: "Turns with Ball",
            steps: [
                "Dribble the ball forward 5 steps.",
                "Stop and turn back.",
                "Use the sole of your foot for the turn.",
                "Repeat 8 times.",
                "Rest for a minute."
            ]
        ),
        // 13. Simple Leg Stretching
        PersonalTrainingShortPassModel(
            title: "Simple Leg Stretching",
            steps: [
                "Stand straight.",
                "Gently bend down towards your toes.",
                "Return to the starting position.",
                "Stretch left, then right.",
                "Relax your shoulders and breathe."
            ]
        ),
        // 14. Movement Without Ball
        PersonalTrainingShortPassModel(
            title: "Movement Without Ball",
            steps: [
                "Run sideways 5 meters to the right, then to the left.",
                "Maintain your stance.",
                "Add a step forward and backward.",
                "Repeat 3 cycles.",
                "Rest."
            ]
        ),
        // 15. Pair Work (No Contact)
        PersonalTrainingShortPassModel(
            title: "Pair Work (No Contact)",
            steps: [
                "Stand facing each other.",
                "One makes a short pass, the other receives.",
                "Switch roles.",
                "Control the accuracy.",
                "Perform 10 exchanges."
            ]
        ),
        // 16. Leading Pass
        PersonalTrainingShortPassModel(
            title: "Leading Pass",
            steps: [
                "Partner walks forward.",
                "Pass so the ball rolls towards them.",
                "Control the power of the kick.",
                "Repeat 5 times for each foot.",
                "Take a pause."
            ]
        ),
        // 17. Ball and Reaction
        PersonalTrainingShortPassModel(
            title: "Ball and Reaction",
            steps: [
                "Roll the ball on the floor and stop it unexpectedly.",
                "Quickly change direction.",
                "Use both feet.",
                "Repeat 10 cycles.",
                "Recover breath."
            ]
        ),
        // 18. Mini Sprint
        PersonalTrainingShortPassModel(
            title: "Mini Sprint",
            steps: [
                "Run 10 meters forward.",
                "Return back.",
                "Repeat 5 times.",
                "Maintain a moderate pace.",
                "Calm breathing at the end."
            ]
        ),
        // 19. Step Technique
        PersonalTrainingShortPassModel(
            title: "Step Technique",
            steps: [
                "Stand in place.",
                "Quickly lift your knees alternately.",
                "Keep your body straight.",
                "3 sets of 30 seconds.",
                "Rest between sets — 40 seconds."
            ]
        ),
        // 20. Light Warm-up with Ball
        PersonalTrainingShortPassModel(
            title: "Light Warm-up with Ball",
            steps: [
                "Slowly dribble the ball forward.",
                "Turn to the left.",
                "Return back.",
                "Lift your head, look forward.",
                "Finish with breathing exercises."
            ]
        ),
        // 21. Pair Passing
        PersonalTrainingShortPassModel(
            title: "Pair Passing",
            steps: [
                "Stand facing each other at a distance of 5 meters.",
                "Pass the ball with the inside of the foot.",
                "After each pass, take 1 step to the side.",
                "Control the trajectory and power of the pass.",
                "5 series of 1.5 minutes with short rest."
            ]
        ),
        // 22. Control in Motion
        PersonalTrainingShortPassModel(
            title: "Control in Motion",
            steps: [
                "Dribble the ball for a distance of 10 meters.",
                "Touch the ball with every step.",
                "Change direction after each run.",
                "Use both feet.",
                "Repeat 5 times."
            ]
        ),
        // 23. "Triangle" Game
        PersonalTrainingShortPassModel(
            title: "\"Triangle\" Game",
            steps: [
                "Place three objects in a triangle (3–4 meters apart).",
                "Dribble the ball in a circle, touching each point.",
                "Perform turns at each vertex.",
                "Change direction every 2 minutes.",
                "Repeat 3 cycles."
            ]
        ),
        // 24. Ball in Limited Space
        PersonalTrainingShortPassModel(
            title: "Ball in Limited Space",
            steps: [
                "Create a 2x2 meter square.",
                "Dribble inside without going out of bounds.",
                "Accelerate movement every 30 seconds.",
                "Switch feet.",
                "Rest 1 minute between series."
            ]
        ),
        // 25. Change of Direction
        PersonalTrainingShortPassModel(
            title: "Change of Direction",
            steps: [
                "Dribble the ball 5 meters forward.",
                "Abruptly change direction.",
                "Repeat 10 times.",
                "Switch feet every 5 runs.",
                "Finish with breathing."
            ]
        ),
        // 26. Pass and Move
        PersonalTrainingShortPassModel(
            title: "Pass and Move",
            steps: [
                "Pass to a partner or against a wall.",
                "Immediately change position one step to the right.",
                "Receive the ball back.",
                "Switch sides.",
                "Repeat 5 series of one minute."
            ]
        ),
        // 27. Fast Touches
        PersonalTrainingShortPassModel(
            title: "Fast Touches",
            steps: [
                "Touch the ball with your soles alternately.",
                "Count the rhythm 1–2–1–2.",
                "Do 30 seconds of active work, 30 seconds rest.",
                "Repeat 6 times.",
                "Finish with a light walk."
            ]
        ),
        // 28. Sole Rolls
        PersonalTrainingShortPassModel(
            title: "Sole Rolls",
            steps: [
                "Roll the ball forward and backward with your sole.",
                "Switch feet every 20 seconds.",
                "Try not to let the ball get too far.",
                "6 sets of one minute.",
                "Relax and breathe."
            ]
        ),
        // 29. 180° Turn
        PersonalTrainingShortPassModel(
            title: "180° Turn",
            steps: [
                "Dribble the ball 5 meters.",
                "Turn 180° and dribble back.",
                "Change direction every 2 turns.",
                "Pause for 20 seconds after a series.",
                "Repeat 5 times."
            ]
        ),
        // 30. Control After Pass
        PersonalTrainingShortPassModel(
            title: "Control After Pass",
            steps: [
                "Rebound the ball off a wall.",
                "Receive with the sole or inside of the foot.",
                "Do not let the ball go far.",
                "Switch feet.",
                "Repeat 20 times."
            ]
        ),
        // 31. "Step Forward" Feint
        PersonalTrainingShortPassModel(
            title: "\"Step Forward\" Feint",
            steps: [
                "Dribble the ball forward.",
                "Step towards the ball and sharply move it to the side.",
                "Switch feet.",
                "Repeat 10 series.",
                "Breathe at the end."
            ]
        ),
        // 32. Slalom Around Cones
        PersonalTrainingShortPassModel(
            title: "Slalom Around Cones",
            steps: [
                "Place 5 cones 1.5 meters apart.",
                "Dribble the ball between them.",
                "Use both feet.",
                "Change direction after 3 runs.",
                "Repeat 3 times."
            ]
        ),
        // 33. Short Pass with Reception
        PersonalTrainingShortPassModel(
            title: "Short Pass with Reception",
            steps: [
                "Rebound the ball off a wall.",
                "Receive and pass again.",
                "Watch your body position.",
                "Repeat 20 times with each foot.",
                "Rest for 1 minute."
            ]
        ),
        // 34. Shooting with Both Feet
        PersonalTrainingShortPassModel(
            title: "Shooting with Both Feet",
            steps: [
                "Strike the ball with your right foot.",
                "Then with your left.",
                "Watch the direction.",
                "10 shots for each foot.",
                "Relax and breathe."
            ]
        ),
        // 35. Dribbling with Acceleration
        PersonalTrainingShortPassModel(
            title: "Dribbling with Acceleration",
            steps: [
                "Dribble slowly for 5 meters.",
                "Accelerate for 2 meters.",
                "Slow down again.",
                "Repeat 10 cycles.",
                "Finish with breathing."
            ]
        ),
        // 36. Balance and Touches
        PersonalTrainingShortPassModel(
            title: "Balance and Touches",
            steps: [
                "While standing, toss the ball up.",
                "Receive with your sole.",
                "Switch feet.",
                "Keep your balance.",
                "4 series of one minute."
            ]
        ),
        // 37. Deceptive Movement
        PersonalTrainingShortPassModel(
            title: "Deceptive Movement",
            steps: [
                "Dribble the ball.",
                "Make a fake swing with your leg.",
                "Continue movement in the opposite direction.",
                "10 repetitions.",
                "Rest."
            ]
        ),
        // 38. Dribbling with Control
        PersonalTrainingShortPassModel(
            title: "Dribbling with Control",
            steps: [
                "Dribble the ball for 10 meters.",
                "Change direction every 2 steps.",
                "Watch your balance.",
                "Switch feet every 30 seconds.",
                "Repeat 5 times."
            ]
        ),
        // 39. Change of Pace
        PersonalTrainingShortPassModel(
            title: "Change of Pace",
            steps: [
                "Dribble slowly for 5 seconds.",
                "Accelerate for 3 seconds.",
                "Repeat 10 times.",
                "Switch feet.",
                "Relax."
            ]
        ),
        // 40. Complex Control
        PersonalTrainingShortPassModel(
            title: "Complex Control",
            steps: [
                "Dribble the ball in a figure-eight pattern.",
                "Use both feet.",
                "Change direction every 2 minutes.",
                "Take breathing pauses.",
                "3 sets."
            ]
        ),
        // 41. Receive and Turn
        PersonalTrainingShortPassModel(
            title: "Receive and Turn",
            steps: [
                "Receive the ball with your sole.",
                "Turn and dribble it forward.",
                "Repeat 10 times.",
                "Switch feet.",
                "Light jogging at the end."
            ]
        ),
        // 42. Advanced Dribbling
        PersonalTrainingShortPassModel(
            title: "Advanced Dribbling",
            steps: [
                "Dribble through 5 cones.",
                "Change the amplitude of movement.",
                "Make short touches.",
                "Watch your body position.",
                "4 series."
            ]
        ),
        // 43. Circular Movement
        PersonalTrainingShortPassModel(
            title: "Circular Movement",
            steps: [
                "Mark a circle with a 3-meter radius.",
                "Dribble along the circle.",
                "Change direction every 30 seconds.",
                "Control the rhythm.",
                "Repeat 5 times."
            ]
        ),
        // 44. Passing Practice
        PersonalTrainingShortPassModel(
            title: "Passing Practice",
            steps: [
                "Rebound the ball off a wall 20 times.",
                "Watch the direction.",
                "Switch feet.",
                "Add slight forward movement.",
                "Breathe."
            ]
        ),
        // 45. Ball and Direction
        PersonalTrainingShortPassModel(
            title: "Ball and Direction",
            steps: [
                "Dribble diagonally.",
                "Turn and dribble back.",
                "Repeat 10 times.",
                "Switch feet.",
                "Relax."
            ]
        ),
        // 46. Combined Movements
        PersonalTrainingShortPassModel(
            title: "Combined Movements",
            steps: [
                "Dribble 5 meters.",
                "Perform a feint.",
                "Shoot at the goal.",
                "Receive back.",
                "Repeat 5 series."
            ]
        ),
        // 47. Precise Stop
        PersonalTrainingShortPassModel(
            title: "Precise Stop",
            steps: [
                "Dribble forward.",
                "Stop with your sole on the line.",
                "Repeat 10 times.",
                "Switch feet.",
                "Breathe."
            ]
        ),
        // 48. Reaction Training
        PersonalTrainingShortPassModel(
            title: "Reaction Training",
            steps: [
                "Roll the ball and sharply change direction.",
                "Catch it with your sole.",
                "Repeat 10 times.",
                "Switch sides.",
                "Finish with breathing."
            ]
        ),
        // 49. Pass and Feint
        PersonalTrainingShortPassModel(
            title: "Pass and Feint",
            steps: [
                "Make a pass.",
                "Receive back and perform a feint.",
                "Continue movement.",
                "Switch feet.",
                "Repeat 5 series."
            ]
        ),
        // 50. Finishing the Attack
        PersonalTrainingShortPassModel(
            title: "Finishing the Attack",
            steps: [
                "Dribble 10 meters.",
                "Make a stop.",
                "Shoot at the goal or wall.",
                "Control the trajectory.",
                "Rest 1 minute and repeat 3 times."
            ]
        )
    ]
}
