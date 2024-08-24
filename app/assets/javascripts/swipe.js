function setupSwipe() {
  let touchstartX = 0;
  let touchendX = 0;

  document.addEventListener('touchstart', e => {
      if (e.target.closest('.shopping-list-card')) {
          touchstartX = e.changedTouches[0].screenX;
      }
  }, false);

  document.addEventListener('touchend', e => {
      const card = e.target.closest('.shopping-list-card');
      if (card) {
          touchendX = e.changedTouches[0].screenX;
          if (touchstartX > touchendX + 50) {
              handleLeftSwipe(card);
          }
          else if (touchstartX < touchendX - 50) {
              handleRightSwipe(card);
          }
      }
  }, false);

  function handleLeftSwipe(card) {
      card.classList.add('swipe-left');
      setTimeout(() => {
          card.style.display = 'none';
      }, 1000);
      const checkButton = card.querySelector('.fa-check-to-slot');
      if (checkButton) {
          checkButton.click();
      }
  }

  function handleRightSwipe(card) {
      card.classList.add('swipe-right');
      const deleteButton = card.querySelector('.delete-button');
      if (deleteButton) {
          deleteButton.click();
      }
  }
}

setupSwipe();
