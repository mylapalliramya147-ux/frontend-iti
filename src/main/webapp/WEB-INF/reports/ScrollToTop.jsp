<!DOCTYPE html>
<html>
<head>
    <title>ScrollToTop</title>
    <!-- Additional stylesheets and scripts can be included here -->
    
    
     <style>
        .cursor-pointer {
            cursor: pointer;
        }

        .scroll-to-top {
            position: fixed;
            bottom: 40px;
            right: 40px;
            background-color: #007bff;
            color: #fff;
            width: 40px;
            height: 40px;
            text-align: right;
            border-radius: 50%;
            transition: opacity 0.4s;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.2);
            margin-left: 9px;
        }

        .scroll-to-top:hover {
            opacity: 0.7;
        }
    </style>
    
    
</head>
<body>
    <div class="cursor-pointer">
        <c:if test="${is_visible}">
            <div onclick="scrollToTop()">
                <div class="scroll-to-top">
                    <i class="fa fa-angle-up iconbox" style="font-size: 32px;"></i>
                </div>
            </div>
        </c:if>
    </div>

    <script>
        function scrollToTop() {
            window.scrollTo({
                top: 0,
                behavior: "smooth"
            });
        }
        
        var is_visible = false;
        window.addEventListener("scroll", function() {
            toggleVisibility();
        });

        function toggleVisibility() {
            if (window.pageYOffset > 200) {
                is_visible = true;
            } else {
                is_visible = false;
            }
        }
    </script>
</body>
</html>