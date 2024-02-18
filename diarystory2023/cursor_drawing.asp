 <style>
        .drawing_line{position:relative; z-index:100; height:0;}
        .drawing_line>svg{position:fixed; left:0; top:0; width:100%; height:100%; z-index:1; pointer-events:none;}
        .drawing_line>svg .drawing_line_polyline{fill:none; stroke:#000; stroke-width:1;}
        .drawing_line>svg .drawing_line_circle{fill:black;}
        button{cursor:none;}
    </style>
    <div class="drawing_line">
        <svg class="drawing_line_svg">
            <circle class="drawing_line_circle" cx="0" cy="0" r="0"></circle>
            <polyline class="drawing_line_polyline" points=""></polyline>
        </svg>
    </div>
    <script>
        var polyline = document.querySelector('.drawing_line_polyline');
        var polyPoints = polyline.getAttribute('points');
        // var circle = document.querySelector('.drawing_line_circle');
        // var circleX = circle.getAttribute('cx');
        // var circleY = circle.getAttribute('cy');
        // var circleR = circle.getAttribute('r');

        var total =8;
        var gap = 20;
        var ease = 0.5;
        var debounce_removeLine;
        var debounce_counter = 0;

        var pointer = {
            x: window.innerWidth / 2,
            y: window.innerHeight / 2,
            tx: 0,
            ty: 0,
            dist: 0,
            scale: 1,
            speed: 3,
            circleRadius: 1,
            updateCrds: function () {
                if (this.x != 0) {
                    this.tx += (this.x - this.tx) / this.speed;
                    this.ty += (this.y - this.ty) / this.speed;
                }
            }
        };

        var points = [];

        $(window).on('mousemove', function (e) {
            pointer.x = e.clientX;
            pointer.y = e.clientY;
            debounce_counter = 0;
            drawLine();

            // debounce
            clearTimeout(debounce_removeLine);
            debounce_removeLine = setTimeout(() => {
                drawLine();
            }, 50);

        })

        $(window).on('mousedown', function (e) {
            drawLine();
        });

        $(window).on('mouseup', function (e) {
            drawLine();
        });

        function drawLine() {
            pointer.updateCrds();

            points.push({
                x: pointer.tx,
                y: pointer.ty
            });
            while (points.length > total) {
                points.shift();
                if (points.length > gap) {
                    for (var i = 0; i < 5; i++) {
                        points.shift();
                    }
                }
            }
            var pointsArr = points.map(point => `${point.x},${point.y}`);
            polyPoints = pointsArr.join(' ');
            polyline.setAttribute('points', polyPoints);
            var totalLength = polyline.getTotalLength();
                if(totalLength > 300){
                    polyline.setAttribute('points', '');
                }
            // circle
            // circleX = pointer.x;
            // circleY = pointer.y;
            // circleR = pointer.scale * pointer.circleRadius/2;

            // circle.setAttribute('cx', circleX);
            // circle.setAttribute('cy', circleY);
            // circle.setAttribute('r', circleR);

            // if (debounce_counter > 0) {
            //     debounce_counter--;
            //     requestAnimationFrame(drawLine);
            // }
        }
    </script>
