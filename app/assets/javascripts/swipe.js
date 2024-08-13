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
              handleClickEvent(card);
          }
      }
  }, false);

  function handleClickEvent(card) {
      const checkButton = card.querySelector('.fa-check-to-slot');
      handleSwipeLeft(card);
      if (checkButton) {
          checkButton.click();
      }
  }

  function handleSwipeLeft(card) {
      card.classList.add('swipe-left');
      setTimeout(() => {
          card.style.display = 'none';
      }, 1000);
  }
}

setupSwipe();
