{% highlight javascript %}

var width = window.innerWidth;
var height = $('body').height() - 3;
var halfWidth = width / 2;
var halfHeight = height / 2;

function drawerSketch(processing) {
  // set size
  processing.size(width, height);

  {{content}}
}
// attach the sketch function to the canvas
var processingInstance = new Processing(document.getElementById('sketch'), drawerSketch);

{% endhighlight %}
