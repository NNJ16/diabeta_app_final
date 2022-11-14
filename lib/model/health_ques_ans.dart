import '../components/constants.dart';
import 'diabetes_ques.dart';

class HealthQuestions {
  static List kidneyQuiz = <DiabetesQues>[
    DiabetesQues(
        qno: 1,
        question: "How old are you?",
        type: QuesType.withSlider,
        minValue: 1,
        maxValue: 100,
        defaultValue: 20,
        unit: "years",
        subText: "Your Age"),
    DiabetesQues(
        qno: 2,
        question: "What is your gender?",
        type: QuesType.withTwoButton,
        options: ["Male", "Female"],
        defaultValue: 0),
    DiabetesQues(
        qno: 3,
        question: "What is your hieght?",
        type: QuesType.withSlider,
        minValue: 1,
        maxValue: 200,
        defaultValue: 20,
        unit: "cm",
        subText: "Your Height"),
    DiabetesQues(
        qno: 4,
        question: "What is your weight?",
        type: QuesType.withSlider,
        minValue: 1,
        maxValue: 200,
        defaultValue: 60,
        unit: "Kg",
        subText: "Your Weight"),
    DiabetesQues(
        qno: 5,
        question: "Do you take medicine to a disease?",
        type: QuesType.withTwoButton,
        options: ["Yes", "No"],
        defaultValue: 0),
    DiabetesQues(
        qno: 6,
        question:
            "Has any one in your family had kidney transplant, had kidney failure or been on diagnosis?",
        type: QuesType.withTwoButton,
        options: ["Yes", "No"],
        defaultValue: 0),
    DiabetesQues(
        qno: 7,
        question: "Have your urine amount decreased?",
        type: QuesType.withTwoButton,
        options: ["Yes", "No"],
        defaultValue: 0),
    DiabetesQues(
        qno: 8,
        question: "Are you having diabetes?",
        type: QuesType.withTwoButton,
        options: ["Yes", "No"],
        defaultValue: 0),
  ];

  static List eyeQuiz = <DiabetesQues>[
    DiabetesQues(
        qno: 1,
        question: "How old are you?",
        type: QuesType.withSlider,
        minValue: 1,
        maxValue: 100,
        defaultValue: 20,
        unit: "years",
        subText: "Your Age"),
    DiabetesQues(
        qno: 2,
        question: "What is your gender?",
        type: QuesType.withTwoButton,
        options: ["Male", "Female"],
        defaultValue: 0),
    DiabetesQues(
        qno: 3,
        question: "Do you have blood relatives with Glucoma?",
        type: QuesType.withTwoButton,
        options: ["Yes", "No"],
        defaultValue: 0),
    DiabetesQues(
        qno: 4,
        question: "Have you ever had an eye injury or eye surgery?",
        type: QuesType.withTwoButton,
        options: ["Yes", "No"],
        defaultValue: 0),
    DiabetesQues(
        qno: 5,
        question: "Do you have persistent pain in or around the eye?",
        type: QuesType.withTwoButton,
        options: ["Yes", "No"],
        defaultValue: 0),
    DiabetesQues(
        qno: 6,
        question:
            "Have you noticed a changes in your vision over the last 12 months?",
        type: QuesType.withTwoButton,
        options: ["Yes", "No"],
        defaultValue: 0),
    DiabetesQues(
        qno: 7,
        question: "Are you having diabetes?",
        type: QuesType.withTwoButton,
        options: ["Yes", "No"],
        defaultValue: 0),
  ];

  static List heartQuiz = <DiabetesQues>[
    DiabetesQues(
        qno: 1,
        question: "How old are you?",
        type: QuesType.withSlider,
        minValue: 1,
        maxValue: 100,
        defaultValue: 20,
        unit: "years",
        subText: "Your Age"),
    DiabetesQues(
        qno: 2,
        question: "What is your gender?",
        type: QuesType.withTwoButton,
        options: ["Male", "Female"],
        defaultValue: 0),
    DiabetesQues(
        qno: 3,
        question: "Select your blood pressure level?",
        type: QuesType.withSlider,
        minValue: 60,
        maxValue: 180,
        defaultValue: 120,
        unit: "mmHg",
        subText: "Your Blood Pressure"),
    DiabetesQues(
        qno: 4,
        question: "Select your cholesterol level?",
        type: QuesType.withSlider,
        minValue: 80,
        maxValue: 300,
        defaultValue: 100,
        unit: "mg/dL",
        subText: "Your Cholesterol"),
    DiabetesQues(
        qno: 5,
        question: "Do you have stress?",
        type: QuesType.withTwoButton,
        options: ["Yes", "No"],
        defaultValue: 0),
    DiabetesQues(
        qno: 6,
        question: "Are you smoking?",
        type: QuesType.withTwoButton,
        options: ["Yes", "No"],
        defaultValue: 0),
    DiabetesQues(
        qno: 7,
        question: "Are you active?",
        type: QuesType.withTwoButton,
        options: ["Yes", "No"],
        defaultValue: 0),
    DiabetesQues(
        qno: 8,
        question: "Are you having diabetes?",
        type: QuesType.withTwoButton,
        options: ["Yes", "No"],
        defaultValue: 0),
  ];
}
