const modalDose = () => {
  const allExceptModal = document.querySelector(".wrapper")
  const addDose = document.querySelector(".dose-link")
  const modal = document.querySelector(".add-dose-form")
  addDose.addEventListener('click', (event) => {
    modal.classList.add("display")
    allExceptModal.classList.add("grey")
    console.log(event)
  });
}

export { modalDose }
