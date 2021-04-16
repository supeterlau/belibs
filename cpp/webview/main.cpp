/*
 * main.cpp
 * Copyright (C) 2021 Peter Lau <superpeterlau@outlook.com>
 *
 * Distributed under terms of the MIT license.
 */

/* #include "main.h" */

#include <iostream>
// https://raw.githubusercontent.com/zserge/webview/master/webview.h
#include "webview.h"

using namespace std;

int main()
{
  webview::webview w(true, nullptr);
  w.set_title("Minimal");
  w.set_size(480, 320, WEBVIEW_HINT_NONE);
  w.navigate("https://kernel.org");
  w.run();
  return 0;
}
