<div id="homeCarousel" class="carousel slide shadow-sm" data-bs-ride="carousel">
  <div class="carousel-indicators">
    <button type="button" data-bs-target="#homeCarousel" data-bs-slide-to="0" class="active"></button>
    <button type="button" data-bs-target="#homeCarousel" data-bs-slide-to="1"></button>
    <button type="button" data-bs-target="#homeCarousel" data-bs-slide-to="2"></button>
  </div>
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="${pageContext.request.contextPath}/images/slide1.webp" class="d-block w-100" alt="Slide 1"
        style="height: 300px; object-fit: cover;">
    </div>
    <div class="carousel-item">
      <img src="${pageContext.request.contextPath}/images/slide2.png" class="d-block w-100" alt="Slide 2"
        style="height: 300px; object-fit: cover;">
    </div>
    <div class="carousel-item">
      <img src="${pageContext.request.contextPath}/images/slide3.webp" class="d-block w-100" alt="Slide 3"
        style="height: 300px; object-fit: cover;">
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#homeCarousel" data-bs-slide="prev">
    <span class="carousel-control-prev-icon"></span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#homeCarousel" data-bs-slide="next">
    <span class="carousel-control-next-icon"></span>
  </button>
</div>