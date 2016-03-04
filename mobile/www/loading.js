// setup basic error-handling, in case app fails to load

function ctrl_log() {
  return document.getElementById('logs');
}

function log(x) {
  ctrl_log().innerHTML += x + "<BR/>";
  ctrl_log().parentNode.scrollTop = ctrl_log().clientHeight;
}

var inter = setInterval(function() {
  if (typeof jxcore == 'undefined')
    return;

  clearInterval(inter);
  
  jxcore.isReady(function() {
    log('READY');
    // register log method from UI to jxcore instance
    jxcore('log').register(log);

    jxcore('index.js').loadMainFile(function(ret, err) {
      if (err) {
        alert(JSON.stringify(err));
      } else {
        log('Loaded from', ret, err);
//        jxcore_ready();
      }
    });
  });
}, 5);

window.loadErrorHandler = function (e) {
  console.error(e.error || e)

  // render heading
  var h1 = document.createElement('h1')
  h1.innerText = 'We\'re sorry! Patchwork experienced an error while loading.'
  h1.style.margin = '10px'
  document.body.appendChild(h1)

  // render stack
  var pre = document.createElement('pre')
  pre.style.margin = '10px'
  pre.style.padding = '10px'
  pre.style.boxShadow = '0 2px 4px rgba(0,0,0,0.1)'
  pre.innerText = e.error ? (e.error.stack || e.error.toString()) : e.message
  document.body.appendChild(pre)
}
window.addEventListener('error', window.loadErrorHandler)