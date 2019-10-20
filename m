Return-Path: <SRS0=zw2Y=YN=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=zw2Y=YN=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42312 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfJTNRl (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 20 Oct 2019 09:17:41 -0400
From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2] kernel-doc: rename the kernel-doc directive 'functions' to 'identifiers'
Date: Sun, 20 Oct 2019 21:17:17 +0800
Message-Id: <20191020131717.28990-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-wireless@vger.kernel.org, linux-fpga@vger.kernel.org, linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, Matthew Wilcox <willy@infradead.org>, jani.nikula@linux.intel.com, Thomas Zimmermann <tzimmermann@suse.de>, Changbin Du <changbin.du@gmail.com>

The 'functions' directive is not only for functions, but also works for
structs/unions. So the name is misleading. This patch renames it to
'identifiers', which specific the functions/types to be included in
documentation. We keep the old name as an alias of the new one before
all documentation are updated.

Signed-off-by: Changbin Du <changbin.du@gmail.com>

---
v2:
  o use 'identifiers' as the new directive name.
---
 Documentation/doc-guide/kernel-doc.rst | 29 ++++++++++++++------------
 Documentation/sphinx/kerneldoc.py      | 19 ++++++++++-------
 2 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index 192c36af39e2..fff6604631ea 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -476,6 +476,22 @@ internal: *[source-pattern ...]*
     .. kernel-doc:: drivers/gpu/drm/i915/intel_audio.c
        :internal:
 
+identifiers: *[ function/type ...]*
+  Include documentation for each *function* and *type* in *source*.
+  If no *function* is specified, the documentation for all functions
+  and types in the *source* will be included.
+
+  Examples::
+
+    .. kernel-doc:: lib/bitmap.c
+       :identifiers: bitmap_parselist bitmap_parselist_user
+
+    .. kernel-doc:: lib/idr.c
+       :identifiers:
+
+functions: *[ function/type ...]*
+  This is an alias of the 'identifiers' directive and deprecated.
+
 doc: *title*
   Include documentation for the ``DOC:`` paragraph identified by *title* in
   *source*. Spaces are allowed in *title*; do not quote the *title*. The *title*
@@ -488,19 +504,6 @@ doc: *title*
     .. kernel-doc:: drivers/gpu/drm/i915/intel_audio.c
        :doc: High Definition Audio over HDMI and Display Port
 
-functions: *[ function ...]*
-  Include documentation for each *function* in *source*.
-  If no *function* is specified, the documentation for all functions
-  and types in the *source* will be included.
-
-  Examples::
-
-    .. kernel-doc:: lib/bitmap.c
-       :functions: bitmap_parselist bitmap_parselist_user
-
-    .. kernel-doc:: lib/idr.c
-       :functions:
-
 Without options, the kernel-doc directive includes all documentation comments
 from the source file.
 
diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
index 1159405cb920..0689f9c37f1e 100644
--- a/Documentation/sphinx/kerneldoc.py
+++ b/Documentation/sphinx/kerneldoc.py
@@ -59,9 +59,10 @@ class KernelDocDirective(Directive):
     optional_arguments = 4
     option_spec = {
         'doc': directives.unchanged_required,
-        'functions': directives.unchanged,
         'export': directives.unchanged,
         'internal': directives.unchanged,
+        'identifiers': directives.unchanged,
+        'functions': directives.unchanged,  # alias of 'identifiers'
     }
     has_content = False
 
@@ -71,6 +72,7 @@ class KernelDocDirective(Directive):
 
         filename = env.config.kerneldoc_srctree + '/' + self.arguments[0]
         export_file_patterns = []
+        identifiers = None
 
         # Tell sphinx of the dependency
         env.note_dependency(os.path.abspath(filename))
@@ -86,19 +88,22 @@ class KernelDocDirective(Directive):
             export_file_patterns = str(self.options.get('internal')).split()
         elif 'doc' in self.options:
             cmd += ['-function', str(self.options.get('doc'))]
+        elif 'identifiers' in self.options:
+            identifiers = self.options.get('identifiers').split()
         elif 'functions' in self.options:
-            functions = self.options.get('functions').split()
-            if functions:
-                for f in functions:
-                    cmd += ['-function', f]
-            else:
-                cmd += ['-no-doc-sections']
+            identifiers = self.options.get('functions').split()
 
         for pattern in export_file_patterns:
             for f in glob.glob(env.config.kerneldoc_srctree + '/' + pattern):
                 env.note_dependency(os.path.abspath(f))
                 cmd += ['-export-file', f]
 
+        if identifiers:
+            for i in identifiers:
+                cmd += ['-function', i]
+        elif identifiers is not None:
+            cmd += ['-no-doc-sections']
+
         cmd += [filename]
 
         try:
-- 
2.20.1
