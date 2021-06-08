/*
 * http.js
 * Copyright (C) 2021 Peter Lau <superpeterlau@outlook.com>
 *
 * Distributed under terms of the MIT license.
 */

function echo(r) {
  r.return(
    200,
    "Design is not just what it looks like and feels like. Design is how it works."
  );
}

export default { echo };
