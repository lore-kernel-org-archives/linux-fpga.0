Return-Path: <SRS0=VzZv=6Q=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=VzZv=6Q=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:52364 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbgEBN0V (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 2 May 2020 09:26:21 -0400
Date: Sat, 2 May 2020 16:24:19 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] fpga: dfl: fme: add performance reporting support
Message-ID: <20200502132419.GA41486@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: hao.wu@intel.com
Cc: linux-fpga@vger.kernel.org

Hello Wu Hao,

The patch 724142f8c42a: "fpga: dfl: fme: add performance reporting
support" from Apr 27, 2020, leads to the following static checker
warning:

	drivers/fpga/dfl-fme-perf.c:948 fme_perf_offline_cpu()
	error: potential NULL dereference 'priv'.

drivers/fpga/dfl-fme-perf.c
   941  static int fme_perf_offline_cpu(unsigned int cpu, struct hlist_node *node)
   942  {
   943          struct fme_perf_priv *priv;
   944          int target;
   945  
   946          priv = hlist_entry_safe(node, struct fme_perf_priv, node);
                                  ^^^^^
It doesn't make sense to use the _safe() version if we're not going to
check for NULL.

   947  
   948          if (cpu != priv->cpu)
   949                  return 0;
   950  
   951          target = cpumask_any_but(cpu_online_mask, cpu);
   952          if (target >= nr_cpu_ids)
   953                  return 0;
   954  
   955          priv->cpu = target;
   956          return 0;
   957  }

regards,
dan carpenter
