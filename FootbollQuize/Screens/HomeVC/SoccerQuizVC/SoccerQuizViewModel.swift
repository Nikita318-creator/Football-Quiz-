import UIKit

struct SoccerQuizModel {
    let question: String
    let options: [String]
    let correctOption: Int
}


class SoccerQuizViewModel {
    var model: [SoccerQuizModel] = []
    
    let currentModelNumber: Int
    
    init(currentModelNumber: Int) {
        self.currentModelNumber = currentModelNumber
        setCurrentModel(index: currentModelNumber)
    }
    
    func setCurrentModel(index: Int) {
        switch index {
        case 0:
            model = model3min
        case 1:
            model = model5min
        case 2:
            model = model7min
        default:
            model = model3min
        }
    }
    
    let model3min: [SoccerQuizModel] = [
        SoccerQuizModel(
            question: "How many players start on the field in a football team?",
            options: ["9", "10", "11", "12"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What is the kick taken from the corner of the field called?",
            options: ["Strong kick", "Corner kick", "Short pass", "Dummy move"],
            correctOption: 1
        ),
        SoccerQuizModel(
            question: "Which part of the foot is usually used for accurate passing?",
            options: ["Heel", "Outside of the foot", "Inside of the foot", "Toe"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What do you call the player who protects the goal?",
            options: ["Striker", "Midfielder", "Goalkeeper", "Defender"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What does the referee signal with a red card?",
            options: ["End of match", "Substitution", "Bad pass", "Player dismissal"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "What is the first kick that starts the match called?",
            options: ["Throw", "Kick-in", "Bounce", "Kickoff"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "What are field players *not* allowed to do with their hands?",
            options: ["Pass", "Run", "Touch the ball", "Turn"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What do you call a goal scored with the head?",
            options: ["Top goal", "Touch", "High shot", "Header"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "Which body part is mainly used to control the ball?",
            options: ["Body", "Shoulders", "Head", "Feet"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "Where is football usually played?",
            options: ["Room", "Track", "Gym", "Field"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "When does a referee give a yellow card?",
            options: ["For a goal", "For substitution", "For breaking the rules", "For a back pass"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "Which player usually makes many passes?",
            options: ["Forward", "Midfielder", "Goalkeeper", "Center back"],
            correctOption: 1
        ),
        SoccerQuizModel(
            question: "How many halves are in a football match?",
            options: ["1", "2", "3", "4"],
            correctOption: 1
        ),
        SoccerQuizModel(
            question: "What does the referee do when the ball goes out of play?",
            options: ["Sends off a player", "Gives a free kick", "Signals for a throw or kick", "Calls offside"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "Which part of the foot is best for long-distance shots?",
            options: ["Inside", "Heel", "Instep", "Toe"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What is an offside?",
            options: ["Heading the ball", "Handball foul", "Free-kick goal", "Being in an illegal position"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "Which player usually plays closest to the opponent's goal?",
            options: ["Defender", "Midfielder", "Forward", "Goalkeeper"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What is the foul called when a player pushes an opponent?",
            options: ["Pass", "Shot", "Foul", "Interception"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "How many substitutions are usually allowed?",
            options: ["1", "2", "3–5 depending on the tournament", "9"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What is the kick taken from 11 meters called?",
            options: ["Sprint", "Lob", "Penalty", "Corner"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "Who restarts the game after a goal is scored?",
            options: ["Scoring team", "Conceding team", "Referee", "Goalkeeper"],
            correctOption: 1
        ),
        SoccerQuizModel(
            question: "What helps improve the accuracy of a shot?",
            options: ["Running", "Jumping", "Foot control", "Whistle"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What does a referee’s whistle mean?",
            options: ["Break starts", "Match starts", "Stop of play", "All of the above"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "Which player helps both in defense and attack?",
            options: ["Goalkeeper", "Midfielder", "Forward", "Technician"],
            correctOption: 1
        ),
        SoccerQuizModel(
            question: "What should players do before training?",
            options: ["Play full power immediately", "Shoot on goal right away", "Light warm-up", "Kick the ball 20 times"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "Which player stays closest to their own goal?",
            options: ["Defender", "Midfielder", "Forward", "Goalkeeper"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "What does the referee do when a foul is committed?",
            options: ["Runs to the player", "Shouts", "Raises hand or whistles", "Passes the ball"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What is an aerial pass called?",
            options: ["Roll pass", "Low pass", "Cross", "Sliding pass"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "How long is a standard football match?",
            options: ["60 minutes", "80 minutes", "90 minutes", "100 minutes"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What is it called when a team controls the ball?",
            options: ["Defense", "Passive play", "Formation", "Attack"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "What is a forward pass that breaks the defense line called?",
            options: ["Short pass", "Back pass", "Through ball", "Side pass"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "Which body part may NOT be used to score a goal?",
            options: ["Head", "Chest", "Foot", "Hand (except goalkeeper)"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "What is an attempt to win the ball from an opponent called?",
            options: ["Shot", "Pass", "Tackle", "Feint"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What is a throw-in?",
            options: ["Shot on goal", "Free kick", "Ball thrown in from the sideline", "Corner kick"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "Where does a defender usually play?",
            options: ["Opponent’s wing", "In front of the goal", "Near own goal", "Center field"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What does a player do when dribbling?",
            options: ["Shoots the ball", "Stands still", "Controls the ball while moving", "Removes equipment"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What is a sharp side movement to trick an opponent called?",
            options: ["Shot", "Pass", "Turn", "Feint"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "From where is a penalty usually taken?",
            options: ["Center circle", "Corner", "Free kick wall", "11-meter mark"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "How does a team start the second half?",
            options: ["Corner kick", "Throw-in", "Penalty", "Kickoff"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "Who controls the movement of the ball between lines?",
            options: ["Goalkeeper", "Midfielder", "Defender", "Assistant referee"],
            correctOption: 1
        ),
        SoccerQuizModel(
            question: "What should a player do for an accurate pass?",
            options: ["Run backward", "Squat", "Look at the ball and teammate", "Shout"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What is it called when the ball crosses the goal line?",
            options: ["Bounce", "Chip", "Goal", "Penalty"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What does a high lifted ball usually indicate?",
            options: ["Foul", "Throw", "Cross or lofted pass", "Offside"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What starts each half?",
            options: ["Corner kick", "Free kick", "Throw-in", "Kickoff"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "What helps a player see teammates better?",
            options: ["Strength", "Field of view", "Head up", "Backwards running"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What helps deliver a good forward pass?",
            options: ["Closing eyes", "Standing still", "Hand movement", "Proper body orientation"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "What is a kick taken without stopping the ball called?",
            options: ["Pass", "Control", "Switch", "Volley"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "What helps keep balance?",
            options: ["Quick jumps", "Hard shots", "Body position", "High ball"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What is the wide area on the side of the field called?",
            options: ["Point", "Center", "Wing", "Near zone"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "How is a throw-in performed?",
            options: ["One hand", "Foot", "Forehead", "Two hands behind the head"],
            correctOption: 3
        )
    ]
    
    let model5min: [SoccerQuizModel] = [
        SoccerQuizModel(
            question: "How many players start on the field in a football team?",
            options: ["9", "10", "11", "12"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What is the kick taken from the corner of the field called?",
            options: ["Strong kick", "Corner kick", "Short pass", "Dummy move"],
            correctOption: 1
        ),
        SoccerQuizModel(
            question: "Which part of the foot is usually used for accurate passing?",
            options: ["Heel", "Outside of the foot", "Inside of the foot", "Toe"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What do you call the player who protects the goal?",
            options: ["Striker", "Midfielder", "Goalkeeper", "Defender"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What does the referee signal with a red card?",
            options: ["End of match", "Substitution", "Bad pass", "Player dismissal"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "What is the first kick that starts the match called?",
            options: ["Throw", "Kick-in", "Bounce", "Kickoff"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "What are field players *not* allowed to do with their hands?",
            options: ["Pass", "Run", "Touch the ball", "Turn"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What do you call a goal scored with the head?",
            options: ["Top goal", "Touch", "High shot", "Header"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "Which body part is mainly used to control the ball?",
            options: ["Body", "Shoulders", "Head", "Feet"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "Where is football usually played?",
            options: ["Room", "Track", "Gym", "Field"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "When does a referee give a yellow card?",
            options: ["For a goal", "For substitution", "For breaking the rules", "For a back pass"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "Which player usually makes many passes?",
            options: ["Forward", "Midfielder", "Goalkeeper", "Center back"],
            correctOption: 1
        ),
        SoccerQuizModel(
            question: "How many halves are in a football match?",
            options: ["1", "2", "3", "4"],
            correctOption: 1
        ),
        SoccerQuizModel(
            question: "What does the referee do when the ball goes out of play?",
            options: ["Sends off a player", "Gives a free kick", "Signals for a throw or kick", "Calls offside"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "Which part of the foot is best for long-distance shots?",
            options: ["Inside", "Heel", "Instep", "Toe"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What is an offside?",
            options: ["Heading the ball", "Handball foul", "Free-kick goal", "Being in an illegal position"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "Which player usually plays closest to the opponent's goal?",
            options: ["Defender", "Midfielder", "Forward", "Goalkeeper"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What is the foul called when a player pushes an opponent?",
            options: ["Pass", "Shot", "Foul", "Interception"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "How many substitutions are usually allowed?",
            options: ["1", "2", "3–5 depending on the tournament", "9"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What is the kick taken from 11 meters called?",
            options: ["Sprint", "Lob", "Penalty", "Corner"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "Who restarts the game after a goal is scored?",
            options: ["Scoring team", "Conceding team", "Referee", "Goalkeeper"],
            correctOption: 1
        ),
        SoccerQuizModel(
            question: "What helps improve the accuracy of a shot?",
            options: ["Running", "Jumping", "Foot control", "Whistle"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What does a referee’s whistle mean?",
            options: ["Break starts", "Match starts", "Stop of play", "All of the above"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "Which player helps both in defense and attack?",
            options: ["Goalkeeper", "Midfielder", "Forward", "Technician"],
            correctOption: 1
        ),
        SoccerQuizModel(
            question: "What should players do before training?",
            options: ["Play full power immediately", "Shoot on goal right away", "Light warm-up", "Kick the ball 20 times"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "Which player stays closest to their own goal?",
            options: ["Defender", "Midfielder", "Forward", "Goalkeeper"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "What does the referee do when a foul is committed?",
            options: ["Runs to the player", "Shouts", "Raises hand or whistles", "Passes the ball"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What is an aerial pass called?",
            options: ["Roll pass", "Low pass", "Cross", "Sliding pass"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "How long is a standard football match?",
            options: ["60 minutes", "80 minutes", "90 minutes", "100 minutes"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What is it called when a team controls the ball?",
            options: ["Defense", "Passive play", "Formation", "Attack"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "What is a forward pass that breaks the defense line called?",
            options: ["Short pass", "Back pass", "Through ball", "Side pass"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "Which body part may NOT be used to score a goal?",
            options: ["Head", "Chest", "Foot", "Hand (except goalkeeper)"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "What is an attempt to win the ball from an opponent called?",
            options: ["Shot", "Pass", "Tackle", "Feint"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What is a throw-in?",
            options: ["Shot on goal", "Free kick", "Ball thrown in from the sideline", "Corner kick"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "Where does a defender usually play?",
            options: ["Opponent’s wing", "In front of the goal", "Near own goal", "Center field"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What does a player do when dribbling?",
            options: ["Shoots the ball", "Stands still", "Controls the ball while moving", "Removes equipment"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What is a sharp side movement to trick an opponent called?",
            options: ["Shot", "Pass", "Turn", "Feint"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "From where is a penalty usually taken?",
            options: ["Center circle", "Corner", "Free kick wall", "11-meter mark"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "How does a team start the second half?",
            options: ["Corner kick", "Throw-in", "Penalty", "Kickoff"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "Who controls the movement of the ball between lines?",
            options: ["Goalkeeper", "Midfielder", "Defender", "Assistant referee"],
            correctOption: 1
        ),
        SoccerQuizModel(
            question: "What should a player do for an accurate pass?",
            options: ["Run backward", "Squat", "Look at the ball and teammate", "Shout"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What is it called when the ball crosses the goal line?",
            options: ["Bounce", "Chip", "Goal", "Penalty"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What does a high lifted ball usually indicate?",
            options: ["Foul", "Throw", "Cross or lofted pass", "Offside"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What starts each half?",
            options: ["Corner kick", "Free kick", "Throw-in", "Kickoff"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "What helps a player see teammates better?",
            options: ["Strength", "Field of view", "Head up", "Backwards running"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What helps deliver a good forward pass?",
            options: ["Closing eyes", "Standing still", "Hand movement", "Proper body orientation"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "What is a kick taken without stopping the ball called?",
            options: ["Pass", "Control", "Switch", "Volley"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "What helps keep balance?",
            options: ["Quick jumps", "Hard shots", "Body position", "High ball"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What is the wide area on the side of the field called?",
            options: ["Point", "Center", "Wing", "Near zone"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "How is a throw-in performed?",
            options: ["One hand", "Foot", "Forehead", "Two hands behind the head"],
            correctOption: 3
        )
    ].reversed()
    
    let model7min: [SoccerQuizModel] = [
        SoccerQuizModel(
            question: "What is a forward pass that breaks the defense line called?",
            options: ["Short pass", "Back pass", "Through ball", "Side pass"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "Which body part may NOT be used to score a goal?",
            options: ["Head", "Chest", "Foot", "Hand (except goalkeeper)"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "What is an attempt to win the ball from an opponent called?",
            options: ["Shot", "Pass", "Tackle", "Feint"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What is a throw-in?",
            options: ["Shot on goal", "Free kick", "Ball thrown in from the sideline", "Corner kick"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "Where does a defender usually play?",
            options: ["Opponent’s wing", "In front of the goal", "Near own goal", "Center field"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What does a player do when dribbling?",
            options: ["Shoots the ball", "Stands still", "Controls the ball while moving", "Removes equipment"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What is a sharp side movement to trick an opponent called?",
            options: ["Shot", "Pass", "Turn", "Feint"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "From where is a penalty usually taken?",
            options: ["Center circle", "Corner", "Free kick wall", "11-meter mark"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "Which body part is mainly used to control the ball?",
            options: ["Body", "Shoulders", "Head", "Feet"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "Where is football usually played?",
            options: ["Room", "Track", "Gym", "Field"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "When does a referee give a yellow card?",
            options: ["For a goal", "For substitution", "For breaking the rules", "For a back pass"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "Which player usually makes many passes?",
            options: ["Forward", "Midfielder", "Goalkeeper", "Center back"],
            correctOption: 1
        ),
        SoccerQuizModel(
            question: "How many halves are in a football match?",
            options: ["1", "2", "3", "4"],
            correctOption: 1
        ),
        SoccerQuizModel(
            question: "What does the referee do when the ball goes out of play?",
            options: ["Sends off a player", "Gives a free kick", "Signals for a throw or kick", "Calls offside"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "Which part of the foot is best for long-distance shots?",
            options: ["Inside", "Heel", "Instep", "Toe"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What is an offside?",
            options: ["Heading the ball", "Handball foul", "Free-kick goal", "Being in an illegal position"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "Which player usually plays closest to the opponent's goal?",
            options: ["Defender", "Midfielder", "Forward", "Goalkeeper"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "Which player stays closest to their own goal?",
            options: ["Defender", "Midfielder", "Forward", "Goalkeeper"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "What does the referee do when a foul is committed?",
            options: ["Runs to the player", "Shouts", "Raises hand or whistles", "Passes the ball"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What is an aerial pass called?",
            options: ["Roll pass", "Low pass", "Cross", "Sliding pass"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "How long is a standard football match?",
            options: ["60 minutes", "80 minutes", "90 minutes", "100 minutes"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What is it called when a team controls the ball?",
            options: ["Defense", "Passive play", "Formation", "Attack"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "How does a team start the second half?",
            options: ["Corner kick", "Throw-in", "Penalty", "Kickoff"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "Who controls the movement of the ball between lines?",
            options: ["Goalkeeper", "Midfielder", "Defender", "Assistant referee"],
            correctOption: 1
        ),
        SoccerQuizModel(
            question: "What should a player do for an accurate pass?",
            options: ["Run backward", "Squat", "Look at the ball and teammate", "Shout"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What is it called when the ball crosses the goal line?",
            options: ["Bounce", "Chip", "Goal", "Penalty"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What does a high lifted ball usually indicate?",
            options: ["Foul", "Throw", "Cross or lofted pass", "Offside"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What starts each half?",
            options: ["Corner kick", "Free kick", "Throw-in", "Kickoff"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "What helps a player see teammates better?",
            options: ["Strength", "Field of view", "Head up", "Backwards running"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What helps deliver a good forward pass?",
            options: ["Closing eyes", "Standing still", "Hand movement", "Proper body orientation"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "What is a kick taken without stopping the ball called?",
            options: ["Pass", "Control", "Switch", "Volley"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "What helps keep balance?",
            options: ["Quick jumps", "Hard shots", "Body position", "High ball"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What is the wide area on the side of the field called?",
            options: ["Point", "Center", "Wing", "Near zone"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "How is a throw-in performed?",
            options: ["One hand", "Foot", "Forehead", "Two hands behind the head"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "How many players start on the field in a football team?",
            options: ["9", "10", "11", "12"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What is the kick taken from the corner of the field called?",
            options: ["Strong kick", "Corner kick", "Short pass", "Dummy move"],
            correctOption: 1
        ),
        SoccerQuizModel(
            question: "Which part of the foot is usually used for accurate passing?",
            options: ["Heel", "Outside of the foot", "Inside of the foot", "Toe"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What is the foul called when a player pushes an opponent?",
            options: ["Pass", "Shot", "Foul", "Interception"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "How many substitutions are usually allowed?",
            options: ["1", "2", "3–5 depending on the tournament", "9"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What is the kick taken from 11 meters called?",
            options: ["Sprint", "Lob", "Penalty", "Corner"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "Who restarts the game after a goal is scored?",
            options: ["Scoring team", "Conceding team", "Referee", "Goalkeeper"],
            correctOption: 1
        ),
        SoccerQuizModel(
            question: "What helps improve the accuracy of a shot?",
            options: ["Running", "Jumping", "Foot control", "Whistle"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What does a referee’s whistle mean?",
            options: ["Break starts", "Match starts", "Stop of play", "All of the above"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "Which player helps both in defense and attack?",
            options: ["Goalkeeper", "Midfielder", "Forward", "Technician"],
            correctOption: 1
        ),
        SoccerQuizModel(
            question: "What should players do before training?",
            options: ["Play full power immediately", "Shoot on goal right away", "Light warm-up", "Kick the ball 20 times"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What do you call the player who protects the goal?",
            options: ["Striker", "Midfielder", "Goalkeeper", "Defender"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What does the referee signal with a red card?",
            options: ["End of match", "Substitution", "Bad pass", "Player dismissal"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "What is the first kick that starts the match called?",
            options: ["Throw", "Kick-in", "Bounce", "Kickoff"],
            correctOption: 3
        ),
        SoccerQuizModel(
            question: "What are field players *not* allowed to do with their hands?",
            options: ["Pass", "Run", "Touch the ball", "Turn"],
            correctOption: 2
        ),
        SoccerQuizModel(
            question: "What do you call a goal scored with the head?",
            options: ["Top goal", "Touch", "High shot", "Header"],
            correctOption: 3
        )
    ]
}
