// Entry point for the build script in your package.json
import "flower";
import "@hotwired/turbo-rails"
import "./controllers"
import "@fortawesome/fontawesome-free/js/all";
//Turbo.session.drive = false



document.addEventListener("turbo:load", () => {
  let currentQuestion = 1;
  const totalQuestions = 10;

  const startButton = document.getElementById('start-questions');
  const startDescription = document.getElementById('start-description');

  //診断の説明を非表示にする
  startButton.addEventListener('click', () => {
    startButton.classList.add('hidden');
    startDescription.classList.add('hidden');

    // 初めの質問を表示
    document.getElementById(`question_${currentQuestion}`).classList.remove('hidden');
    updateButtonVisibility();
  });

  // ボタンの表示を更新する関数
  function updateButtonVisibility() {
    document.getElementById(`next_button`).classList.toggle('hidden', currentQuestion >= 10);  // 質問10の場合、次へボタンを非表示に
    document.getElementById(`previous_button`).classList.toggle('hidden', currentQuestion <= 1);  // 質問1の場合、戻るボタンを非表示に
    document.getElementById(`submit-button`).classList.toggle('hidden', currentQuestion !== 10);  // 質問10以外の場合、結果ボタンを非表示に
  }

  // 選択されたラジオボタンのラベルの背景色を変える関数
  function updateSelectedLabelBackground(questionNumber) {
    const selectedAnswer = document.querySelector(`input[data-question-id="${questionNumber}"]:checked`);
    if (selectedAnswer) {
        // すべてのラベルから.selected-labelを削除
        document.querySelectorAll(`[for^="calculate_answer_${questionNumber}_"]`).forEach(label => {
            label.classList.remove('bg-customGreen2');
        });

        // 選択されたラジオボタンのラベルに.selected-labelを追加
        const selectedLabel = document.querySelector(`label[for="${selectedAnswer.id}"]`);
        selectedLabel.classList.add('bg-customGreen2');
    }
  }

  document.addEventListener('change', (event) => {
    if (event.target.classList.contains('radio')) {
        updateSelectedLabelBackground(event.target.dataset.questionId);
    }
  });

  //次へボタンのクリック処理
  document.addEventListener('click', (event) => {

    if (event.target.dataset.action === 'next-question'){
      // 現在の質問で選択されている選択肢を取得
      const selectedAnswer = document.querySelector(`input[data-question-id="${currentQuestion}"]:checked`);

      if (!selectedAnswer) {
        // 選択されていない場合はエラーメッセージを表示して処理を終了
        document.getElementById(`error_message`).classList.remove('hidden');
        return;
      } else {
        // 選択されている場合は、エラーメッセージが表示されている場合は隠す
        document.getElementById(`error_message`).classList.add('hidden');
      }

      document.getElementById(`question_${currentQuestion}`).classList.add('hidden');
      currentQuestion++;
      document.getElementById(`question_${currentQuestion}`).classList.remove('hidden');
      updateSelectedLabelBackground(currentQuestion);
      updateButtonVisibility();
    } else if (event.target.dataset.action === 'previous-question') {
      document.getElementById(`question_${currentQuestion}`).classList.add('hidden');
      currentQuestion--;
      document.getElementById(`question_${currentQuestion}`).classList.remove('hidden');
      updateSelectedLabelBackground(currentQuestion);
      updateButtonVisibility();
    }
  });

});
