if (location.pathname.match("posts/new")){
  document.addEventListener("DOMContentLoaded", () => {
    console.log("読み込み完了");
    const inputElement = document.getElementById("post_name");
    inputElement.addEventListener("keyup", () => {
      const keyword = document.getElementById("post_name").value;
      const XHR = new XMLHttpRequest();
      XHR.open("GET", `tag_search/?keyword=${keyword}`, true);
      XHR.responseType = "json";
      XHR.send();
      XHR.onload = () => {
        const tagName = XHR.response.keyword;
        const searchResult = document.getElementById("search-result");
        tagName.forEach((tag) => {
          const childElement = document.createElement("div");
          childElement.setAttribute("class", "child");
          childElement.setAttribute("id", tag.id);
          childElement.innerHTML = tag.name;
          searchResult.appendChild(childElement);
          const clickElement = document.getElementById(tag.id);
          clickElement.addEventListener("click", () => {
            document.getElementById("tweets_tag_name").value = clickElement.textContent;
            clickElement.remove();
          });
        });
      };
    });
  });
};