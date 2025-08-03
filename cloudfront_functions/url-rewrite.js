/**
 * CloudFront Function: URL Rewrite and WWW Redirect
 *
 * This function performs two main tasks:
 * 1. WWW Redirect: Automatically redirects any www subdomain (www.example.com)
 *    to the bare domain (example.com) with a 301 redirect, preserving the full
 *    URL path and query parameters.
 * 2. URL Rewriting: Adds index.html to directory requests and requests without
 *    file extensions for proper static site serving.
 *
 * The function works universally for any domain without requiring hard-coded
 * domain lists, making it maintainable and scalable.
 *
 * Examples:
 * - www.example.com/about → https://example.com/about (301 redirect)
 * - www.example.com/page?param=value → https://example.com/page?param=value (301 redirect)
 * - example.com/folder/ → example.com/folder/index.html (rewrite)
 * - example.com/page → example.com/page/index.html (rewrite)
 */

function handler(event) {
  var request = event.request;
  var uri = request.uri;
  var host = request.headers.host.value;

  // Redirect www subdomains to bare domain
  if (host.startsWith("www.")) {
    var bareHost = host.substring(4); // Remove 'www.' prefix
    var redirectUrl = "https://" + bareHost + uri;

    // Preserve query string if present
    if (request.querystring && Object.keys(request.querystring).length > 0) {
      var queryString = "";
      for (var key in request.querystring) {
        if (queryString) queryString += "&";
        var param = request.querystring[key];
        if (param.value) {
          queryString += key + "=" + encodeURIComponent(param.value);
        } else {
          queryString += key;
        }
      }
      redirectUrl += "?" + queryString;
    }

    return {
      statusCode: 301,
      statusDescription: "Moved Permanently",
      headers: {
        location: { value: redirectUrl },
        "cache-control": { value: "max-age=31536000" }, // Cache for 1 year
      },
    };
  }

  // Check whether the URI is missing a file name.
  if (uri.endsWith("/")) {
    request.uri += "index.html";
  }
  // Check whether the URI is missing a file extension.
  else if (!uri.includes(".")) {
    request.uri += "/index.html";
  }

  return request;
}
