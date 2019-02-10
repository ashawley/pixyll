var CACHE_NAME = "pixyll2-20190210093434";

self.addEventListener("install", function(e) {
  e.waitUntil(
    caches.open(CACHE_NAME).then(function(cache) {
      return cache.addAll([
        "/pixyll/css/pixyll.css?201902100934",
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
    caches.match(e.request.url).then(function(response) {
        return response || fetch(e.request.url).then(function(response) {
        var hosts = [
          "https://fonts.googleapis.com",
          "https://maxcdn.bootstrapcdn.com",
          "https://cdnjs.cloudflare.com"
        ];
        hosts.map(function(host) {
          if (e.request.url.indexOf(host) === 0) {
            caches.open(CACHE_NAME).then(function(cache) {
              cache.put(e.request.url, response.clone());
            });
          }
        });
        return response;
      });
    })
  );
});
