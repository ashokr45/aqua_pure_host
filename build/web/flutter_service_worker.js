'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "ad275326164ea32f81b5f9f54fe44626",
"version.json": "c59ceb0e139532041e50de0347feec10",
"index.html": "bf515d1bb00b8e3bc4802ed70316a2d0",
"/": "bf515d1bb00b8e3bc4802ed70316a2d0",
"main.dart.js": "28ba9dc736e0764a25b7bad2ba733219",
"flutter.js": "4b2350e14c6650ba82871f60906437ea",
"favicon.png": "df3602adfa4aa2721e25462de59f81cc",
"icons/Icon-192.png": "c048d4dab179c7151158db63c40ac5f5",
"icons/Icon-maskable-192.png": "c048d4dab179c7151158db63c40ac5f5",
"icons/Icon-maskable-512.png": "d75adc039b0a072942cf706554e405f7",
"icons/Icon-512.png": "d75adc039b0a072942cf706554e405f7",
"manifest.json": "0e9aba4eb8a5c49221700ea80a28236e",
"assets/AssetManifest.json": "3de66e211758557fd68b52fa9d7fd312",
"assets/NOTICES": "20bfb3d9c3e637f18d9c610304823ad5",
"assets/FontManifest.json": "68a2433a7a31c952a7a24f6c3574651a",
"assets/AssetManifest.bin.json": "3f2e77409a00292ef13d4a8f43d8cb50",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "b93248a553f9e8bc17f1065929d5934b",
"assets/packages/iconsax/lib/assets/fonts/iconsax.ttf": "071d77779414a409552e0584dcbfd03d",
"assets/packages/syncfusion_flutter_datagrid/assets/font/FilterIcon.ttf": "c17d858d09fb1c596ef0adbf08872086",
"assets/packages/syncfusion_flutter_datagrid/assets/font/UnsortIcon.ttf": "6d8ab59254a120b76bf53f167e809470",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "69ab3187c328abc7ce29ae61b1352463",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/assets/HMIR2.png": "ed67856e7ad7e55002dc22375050e1ae",
"assets/assets/HMIR3.png": "3dc8812695d47f98a5be3d2a72f2e9b7",
"assets/assets/Branding.png": "e8cf5cb45132e8c29a0ee9adbdd74fcc",
"assets/assets/Group.png": "d77e722edea9928d808656386b2df9a5",
"assets/assets/sample.png": "860e2f52796a6b2964c9fa726fd769df",
"assets/assets/Overlay/Asset%25202.png": "4c46401764be14d9f18ba33a2e689edc",
"assets/assets/Overlay/Asset%25203.png": "dd5fe2b30d44e0af9f48c981a6f8291b",
"assets/assets/Overlay/Asset%25201.png": "f2ab54731effd4da5c104722a7851aa4",
"assets/assets/Overlay/Asset%25204.png": "8aef18db868b7a9255266ec8cf498583",
"assets/assets/Overlay/Asset%25205.png": "25ddaca9591411e4ef3db39f5f60d15a",
"assets/assets/Overlay/Asset%25207.png": "51c3195c874786878fef4b464d3b9710",
"assets/assets/Overlay/Asset%25206.png": "0cce58c6acbdf660e2e6abe9d70a1e8d",
"assets/assets/Overlay/Asset%252018.png": "36061bd18601949f32adfa8b1c2ddd5a",
"assets/assets/Overlay/Asset%252015.png": "c3977785d44c41e8747eaf84bfaf936d",
"assets/assets/Overlay/Asset%252014.png": "cb675e6ca7b7f2f83530e4a29841f23b",
"assets/assets/Overlay/Asset%252016.png": "349234798cab1a842f4970173098d916",
"assets/assets/Overlay/Asset%25208.png": "1be35feaddce8e58b0380de7e83e6db9",
"assets/assets/Overlay/Asset%25209.png": "ec587f94dd4a72f56a6d00fc71a0a75c",
"assets/assets/Overlay/Asset%252017.png": "db0ecf6351f65b92efc9ab372216fbe2",
"assets/assets/Overlay/Asset%252013.png": "ccc43fc485def9a72f9fd8691b287210",
"assets/assets/Overlay/Asset%252012.png": "ae5b65275a91a0dfb38a809137eb6a16",
"assets/assets/Overlay/Asset%252010.png": "cf1ad478902dbecfc4a2b3d512d82335",
"assets/assets/Overlay/Asset%252011.png": "46f6b304a63193ff7228dff3ac8804dd",
"assets/assets/HMIR.png": "8e192440c57392a18b3e8dbd781d2619",
"canvaskit/skwasm.js": "ac0f73826b925320a1e9b0d3fd7da61c",
"canvaskit/skwasm.js.symbols": "96263e00e3c9bd9cd878ead867c04f3c",
"canvaskit/canvaskit.js.symbols": "efc2cd87d1ff6c586b7d4c7083063a40",
"canvaskit/skwasm.wasm": "828c26a0b1cc8eb1adacbdd0c5e8bcfa",
"canvaskit/chromium/canvaskit.js.symbols": "e115ddcfad5f5b98a90e389433606502",
"canvaskit/chromium/canvaskit.js": "b7ba6d908089f706772b2007c37e6da4",
"canvaskit/chromium/canvaskit.wasm": "ea5ab288728f7200f398f60089048b48",
"canvaskit/canvaskit.js": "26eef3024dbc64886b7f48e1b6fb05cf",
"canvaskit/canvaskit.wasm": "e7602c687313cfac5f495c5eac2fb324",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
