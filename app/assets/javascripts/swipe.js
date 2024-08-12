function setupSwipe() {
    const cards = document.querySelectorAll('.shopping-list-card');

    cards.forEach(card => {
        let touchstartX = 0;
        let touchendX = 0;

        card.addEventListener('touchstart', e => {
            touchstartX = e.changedTouches[0].screenX;
        }, false);

        card.addEventListener('touchend', e => {
            touchendX = e.changedTouches[0].screenX;
            if (touchstartX > touchendX + 50) { // Swipe left
                handleClickEvent(card);
            }
        }, false);
    });

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

document.addEventListener('DOMContentLoaded', setupSwipe);
