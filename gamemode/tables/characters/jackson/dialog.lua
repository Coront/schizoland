AS.AddDialog( "jackson", {
    ["greet"] = {
        text = "What can I do for you?",
        response = {
            [1] = { text = "Who are you?", nextdialog = "introduction1", onetime = true },
            [2] = { text = "Do you have any jobs available? (Missions)", reqdialog = "introduction2", menu = "missions"},
            [4] = { text = "I'll be on my way. (Leave)", closedialog = true },
        },
    },
    ["introduction1"] = {
        text = "I'm Jackson, I don't really do much around here besides the farm work, someone's gotta grow the food to keep us full. You seem relatively new around here and I don't recall talking to you, have you been here a while?",
        response = {
            [1] = { text = "No, I'm new to this place. I was looking around for some work to do, or something similar.", nextdialog = "introduction2"},
        }
    },
    ["introduction2"] = {
        text = "Well, in that case, I actually have some problems I need help with if you're willing to lend a hand. Just say the word and I'll get you set up.",
        response = {
            [1] = { text = "Sure, tell me what you need help with. (Missions)", menu = "missions" },
            [2] = { text = "I actually want to ask you something else.", nextdialog = "greet", forcetext = "What is it?"},
            [3] = { text = "No thanks, maybe later. (Leave)", closedialog = true },
        }
    }
} )