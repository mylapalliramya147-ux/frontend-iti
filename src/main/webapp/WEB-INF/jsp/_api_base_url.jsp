<%-- Inject the backend API base URL as a global JS variable for static JS files.
     Usage: <jsp:include page="/WEB-INF/jsp/_api_base_url.jsp"/> before loading
     any static JS that calls the Backend API. --%>
<script>
    window.API_BASE_URL = '${backendBaseUrl}';
</script>
