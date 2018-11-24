

const displayNav = () => {
  const content = document.querySelector(".content")
  const nav = document.querySelector(".cocktail-nav")
  if (document.querySelector(".home") === null) {
    nav.classList.add("flex")
    content.classList.add("content-margin")

  }
}

export { displayNav }
