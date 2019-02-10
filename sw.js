var CACHE_NAME = "pixyll2-20190209204106";

self.addEventListener("install", function(e) {
  e.waitUntil(
    caches.open(CACHE_NAME).then(function(cache) {
      return cache.addAll([
        "/pixyll/css/pixyll.css?201902092041",
        "/pixyll/"
      ]);
    })
  );
});

self.addEventListener("activate", function(e) {
  e.waitUntil(
    caches.keys().then(function(names) {
      return Promise.all(
        names.map(function(name) {
          if (name != CACHE_NAME) {
            return caches.delete(name);
          }
        })
      );
    })
  );
  return clients.claim();
});

addEventListener("fetch", function(e) {
  e.respondWith(
    caches.match(e.request).then(function(response) {
      return response || fetch(e.request.url).then(function(response) {
        var hosts = [
          "//fonts.googleapis.com",
          "//fonts.gstatic.com",
          "//maxcdn.bootstrapcdn.com",
          "//cdnjs.cloudflare.com"
        ];
        hosts.map(function(host) {
          var idx = e.request.url.indexOf(host);
          console.log(e.request.url);
          if (idx > -1 && idx < 7 && response) {
            caches.open(CACHE_NAME).then(function(cache) {
              cache.put(e.request, response.clone());
            });
          }
        });
        return response;
      });
    })
  );
});
