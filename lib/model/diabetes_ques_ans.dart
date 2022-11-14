import '../components/constants.dart';
import 'diabetes_ques.dart';

class DiabeticQuestions {
  static List sampleQuiz1 = <DiabetesQues>[
    DiabetesQues(
        qno: 1,
        question: "What is your gender?",
        type: QuesType.withTwoButton,
        options: ["Male", "Female"],
        defaultValue: 0),
    DiabetesQues(
        qno: 2,
        question: "How old are you?",
        type: QuesType.withSlider,
        minValue: 1,
        maxValue: 100,
        defaultValue: 25,
        unit: "years",
        subText: "Your Age"),
    DiabetesQues(
        qno: 3,
        question: "What is your hieght?",
        type: QuesType.withSlider,
        minValue: 1,
        maxValue: 200,
        defaultValue: 150,
        unit: "cm",
        subText: "Your Height"),
    DiabetesQues(
        qno: 4,
        question: "What is your weight?",
        type: QuesType.withSlider,
        minValue: 1,
        maxValue: 200,
        defaultValue: 70,
        unit: "Kg",
        subText: "Your Weight"),
    DiabetesQues(
        qno: 5,
        question: "Select your blood glucose?",
        type: QuesType.withSlider,
        minValue: 1,
        maxValue: 300,
        defaultValue: 80,
        unit: "mg/dL",
        subText: "Your Blood Pressure"),
    DiabetesQues(
        qno: 6,
        question: "Select your blood pressure?",
        type: QuesType.withSlider,
        minValue: 60,
        maxValue: 180,
        defaultValue: 120,
        unit: "mmHg",
        subText: "Your Blood Pressure"),
    DiabetesQues(
        qno: 7,
        question: "Select your insulin level?",
        type: QuesType.withSlider,
        minValue: 1,
        maxValue: 200,
        defaultValue: 20,
        unit: "muU/ml",
        subText: "Your Insulin"),
    DiabetesQues(
        qno: 8,
        question: "Select your skin thickness?",
        type: QuesType.withSlider,
        minValue: 1,
        maxValue: 50,
        defaultValue: 20,
        unit: "mm",
        subText: "Your Skin Thickness"),
  ];

  static List sampleQuiz2 = <DiabetesQues>[
    DiabetesQues(
        qno: 1,
        question: "What is your gender?",
        type: QuesType.withTwoButton,
        options: ["Male", "Female"],
        defaultValue: 0),
    DiabetesQues(
        qno: 2,
        question: "How old are you?",
        type: QuesType.withSlider,
        minValue: 1,
        maxValue: 100,
        defaultValue: 20,
        unit: "years",
        subText: "Your Age"),
    DiabetesQues(
        qno: 3,
        question: "Do you have Polyuria?",
        type: QuesType.withTwoButton,
        options: ["Yes", "No"],
        defaultValue: 0,
        img: "poliyuria.png",
        des:
            'Polyuria is defined as the frequent passage of large volumes of urine – more than 3 litres a day compared to the normal daily urine output in adults of about 1 to 2 litres.'),
    DiabetesQues(
        qno: 4,
        question: "Do you have Polydipsia?",
        type: QuesType.withTwoButton,
        options: ["Yes", "No"],
        defaultValue: 0,
        img: "polydipsia.png",
        des:
            "Polydipsia is the term given to excessive thirst and is one of the initial symptoms of diabetes. It is also usually accompanied by temporary or prolonged dryness of the mouth."),
    DiabetesQues(
        qno: 5,
        question: "Have you had sudden weight loss?",
        type: QuesType.withTwoButton,
        options: ["Yes", "No"],
        defaultValue: 0,
        img: "suddenweightloss.png",
        des:
            'Sudden weight loss is a noticeable drop in body weight that occurs even if the person is not trying to lose weight.'),
    DiabetesQues(
        qno: 6,
        question: "Do you feel Irritability?",
        type: QuesType.withTwoButton,
        options: ["Yes", "No"],
        defaultValue: 0,
        img: "irritability.png",
        des:
            "Irritability involves feelings of anger or frustration that often arise over even the smallest of things."),
    DiabetesQues(
        qno: 7,
        question: "Do you have Delayed Healing?",
        type: QuesType.withTwoButton,
        options: ["Yes", "No"],
        defaultValue: 0,
        img: "delayedhealing.png",
        des:
            " Delayed wound healing is when it takes longer than normal for a wound to heal."),
    DiabetesQues(
        qno: 8,
        question: "Do you have Partial Paresis?",
        type: QuesType.withTwoButton,
        options: ["Yes", "No"],
        defaultValue: 0,
        img: "partialparalisis.png",
        des:
            "Partial or incomplete paralysis is when you still have some feeling in, and possibly control over, your paralyzed muscles."),
    DiabetesQues(
        qno: 9,
        question: "Do you have Alopecia?",
        type: QuesType.withTwoButton,
        options: ["Yes", "No"],
        defaultValue: 0,
        img: "alpecia.png",
        des:
            " Alopecia areata occurs when the immune system attacks hair follicles and may be brought on by severe stress. The main symptom is hair loss."),
    DiabetesQues(
        qno: 10,
        question: "Do you have Visual Blurring?",
        type: QuesType.withTwoButton,
        options: ["Yes", "No"],
        defaultValue: 0,
        img: "blurredvision.png",
        des:
            "Blurred vision refers to a lack of sharpness of vision resulting in the inability to see fine detail."),
  ];
}
