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

  document.addEventListener('change', e => {
    if (e.target.classList.contains('shopping-list-checkbox')) {
      const card = e.target.closest('.shopping-list-card');
      const ingredientId = e.target.dataset.ingredientId;
      if (e.target.checked) {
        handleAddToPantry(card, ingredientId);
      }
    }
  });

  function handleLeftSwipe(card) {
    const checkbox = card.querySelector('.shopping-list-checkbox');
    checkbox.checked = true;
    handleAddToPantry(card, checkbox.dataset.ingredientId);
  }

  function handleRightSwipe(card) {
    const checkbox = card.querySelector('.shopping-list-checkbox');
    checkbox.checked = false;
    handleDelete(card, checkbox.dataset.ingredientId);
  }

  function handleAddToPantry(card, ingredientId) {
    card.classList.add('cross-out');
    setTimeout(() => {
      card.classList.add('swipe-left');
      setTimeout(() => {
        card.style.display = 'none';
      }, 1000);
      const addButton = document.getElementById(`add-${ingredientId}`);
      if (addButton) {
        addButton.click();
      }
    }, 500);
  }

  function handleDelete(card, ingredientId) {
    card.classList.add('cross-out', 'delete');
    setTimeout(() => {
      card.classList.add('swipe-right');
      setTimeout(() => {
        const deleteButton = document.getElementById(`delete-${ingredientId}`);
        if (deleteButton) {
          deleteButton.click();
        }
      }, 1000);
    }, 500);
  }
}

setupSwipe();
