Return-Path: <SRS0=HHoX=DH=vger.kernel.org=linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0C6C47425
	for <linux-fpga@archiver.kernel.org>; Wed, 30 Sep 2020 13:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A0742075F
	for <linux-fpga@archiver.kernel.org>; Wed, 30 Sep 2020 13:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601472463;
	bh=nm9qJomKwVXcljIx0Ng6FM4B6A36zuOApRHbFINo3A4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wtWbEGgnmrvBwK/8PV40hNiGRk0hywMYiR5s/Z8jXZEzszDYclhP1lFu35sS4I+Uf
	 vUdqGObEyoVQ0BsglriXtysuAUcjuAWk+ZZ100w3MVDOs6wNi76z03078v7wCfXMx0
	 uyJKX5zQtGJADUtTYm6LzYMPtd46dqjqEVCDXowQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbgI3N1Y (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Wed, 30 Sep 2020 09:27:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730240AbgI3NZW (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 30 Sep 2020 09:25:22 -0400
Received: from mail.kernel.org (unknown [95.90.213.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BFCA23A51;
        Wed, 30 Sep 2020 13:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601472321;
        bh=nm9qJomKwVXcljIx0Ng6FM4B6A36zuOApRHbFINo3A4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VYhTrFDMlQ8GXf61TAS9LNhpFwZS+A9+i4k6ZaWE8BkybGFIXvLJZU6A/0wPGqajy
         2/WMXr1jRiKny7/oGQ+wtMbyDkzocB0gvoxZjl5CUskD609gnqgwvMvt17iBObYEL6
         pITFyee7P37o+7wRjrjkZ9hnoA8IzN7LCyoz6BJ0=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kNc6h-001XKi-Gb; Wed, 30 Sep 2020 15:25:19 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 40/52] docs: fpga: replace :c:member: macros
Date:   Wed, 30 Sep 2020 15:25:03 +0200
Message-Id: <720b01d37a7d6f50721d95988cfd9a9e463f43cd.1601467849.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601467849.git.mchehab+huawei@kernel.org>
References: <cover.1601467849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Those macros are not doing the right thing with Sphinx 3,
causing parse errors:

	./Documentation/driver-api/fpga/fpga-mgr.rst:104: WARNING: Unparseable C cross-reference: 'fpga_manager->state'
	Invalid C declaration: Expected end of definition. [error at 12]
	  fpga_manager->state
	  ------------^
	./Documentation/driver-api/fpga/fpga-programming.rst:18: WARNING: Unparseable C cross-reference: 'fpga_region->info'
	Invalid C declaration: Expected end of definition. [error at 11]
	  fpga_region->info
	  -----------^
	./Documentation/driver-api/fpga/fpga-region.rst:62: WARNING: Unparseable C cross-reference: 'fpga_region->bridge_list'
	Invalid C declaration: Expected end of definition. [error at 11]
	  fpga_region->bridge_list
	  -----------^
	./Documentation/driver-api/fpga/fpga-region.rst:62: WARNING: Unparseable C cross-reference: 'fpga_region->get_bridges'
	Invalid C declaration: Expected end of definition. [error at 11]
	  fpga_region->get_bridges
	  -----------^

Replace them by :c:expr:, with does what's desired.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/fpga/fpga-mgr.rst         | 2 +-
 Documentation/driver-api/fpga/fpga-programming.rst | 2 +-
 Documentation/driver-api/fpga/fpga-region.rst      | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst b/Documentation/driver-api/fpga/fpga-mgr.rst
index 22f7885b32c9..917ee22db429 100644
--- a/Documentation/driver-api/fpga/fpga-mgr.rst
+++ b/Documentation/driver-api/fpga/fpga-mgr.rst
@@ -101,7 +101,7 @@ in state.
 API for implementing a new FPGA Manager driver
 ----------------------------------------------
 
-* ``fpga_mgr_states`` —  Values for :c:member:`fpga_manager->state`.
+* ``fpga_mgr_states`` —  Values for :c:expr:`fpga_manager->state`.
 * struct fpga_manager —  the FPGA manager struct
 * struct fpga_manager_ops —  Low level FPGA manager driver ops
 * devm_fpga_mgr_create() —  Allocate and init a manager struct
diff --git a/Documentation/driver-api/fpga/fpga-programming.rst b/Documentation/driver-api/fpga/fpga-programming.rst
index f487ad64dfb9..002392dab04f 100644
--- a/Documentation/driver-api/fpga/fpga-programming.rst
+++ b/Documentation/driver-api/fpga/fpga-programming.rst
@@ -15,7 +15,7 @@ the FPGA manager and bridges.  It will:
  * lock the mutex of the region's FPGA manager
  * build a list of FPGA bridges if a method has been specified to do so
  * disable the bridges
- * program the FPGA using info passed in :c:member:`fpga_region->info`.
+ * program the FPGA using info passed in :c:expr:`fpga_region->info`.
  * re-enable the bridges
  * release the locks
 
diff --git a/Documentation/driver-api/fpga/fpga-region.rst b/Documentation/driver-api/fpga/fpga-region.rst
index 3e52be7e2968..363a8171ab0a 100644
--- a/Documentation/driver-api/fpga/fpga-region.rst
+++ b/Documentation/driver-api/fpga/fpga-region.rst
@@ -61,9 +61,9 @@ during the region's probe function.
 
 The FPGA region will need to specify which bridges to control while programming
 the FPGA.  The region driver can build a list of bridges during probe time
-(:c:member:`fpga_region->bridge_list`) or it can have a function that creates
+(:c:expr:`fpga_region->bridge_list`) or it can have a function that creates
 the list of bridges to program just before programming
-(:c:member:`fpga_region->get_bridges`).  The FPGA bridge framework supplies the
+(:c:expr:`fpga_region->get_bridges`).  The FPGA bridge framework supplies the
 following APIs to handle building or tearing down that list.
 
 * fpga_bridge_get_to_list() — Get a ref of an FPGA bridge, add it to a
-- 
2.26.2

