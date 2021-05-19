Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58D4C433ED
	for <linux-fpga@archiver.kernel.org>; Wed, 19 May 2021 20:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E7246135C
	for <linux-fpga@archiver.kernel.org>; Wed, 19 May 2021 20:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhESUvD (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Wed, 19 May 2021 16:51:03 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:41743 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhESUvC (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 19 May 2021 16:51:02 -0400
Received: by mail-pl1-f181.google.com with SMTP id z4so5555759plg.8;
        Wed, 19 May 2021 13:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CcMXLFh8WFoRN3tO7rpqAMKmtQsUHFOTiMqF7Ll+dO0=;
        b=ZXeGjeJQcIF8LuiurDpI921xxJD2ClFqp8Gc9RBVRq7w444xWMgM9lHTuyZUZFG6od
         T+ATqsjfo+2eGfAVdOqqTuv9tex/4S8CA8qlzSKOtTSvyUZuhRsWTKn7tKtdI0V7dM5d
         P8YYz2EauLjQ6sjdHJxhCecB4TPFwCIKVMe3uDNrWg2UJDWqk0DGb6qx+owpa3s44nM1
         vJu8icuru42gJFflkjg6TCRvfXsV8XFfMcEIaHgFOpwqAc9NVZodJDO3E7X1fIw6/f8x
         lDtgkJGf0agYbJnCO+pQKezPab81hdTtVoknN1rRzNp1gmkyyZqvZ+xNyK025mcskiB+
         LZcg==
X-Gm-Message-State: AOAM533R82TC4KjUAY+Uejvm1CEl6mxz+YCN2lqohNw5OdHRFMxw/c9Y
        FQs+pqGYdpDGsjEdmncDkPA=
X-Google-Smtp-Source: ABdhPJwfYLgu+7Iy+CsGNWU2/kOo53u52oMoq3BBqCD4Dil3FNE8QcD3RwcGcV8UBBcJZ1QW1B4O6g==
X-Received: by 2002:a17:90b:2397:: with SMTP id mr23mr842942pjb.77.1621457382517;
        Wed, 19 May 2021 13:49:42 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id b15sm233638pfi.100.2021.05.19.13.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 13:49:41 -0700 (PDT)
Date:   Wed, 19 May 2021 13:49:41 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     trix@redhat.com
Cc:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] fpga: generalize updating to partial and full
Message-ID: <YKV55XK1Py5YSXZp@epycbox.lan>
References: <20210519204256.1975957-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519204256.1975957-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Tom,

On Wed, May 19, 2021 at 01:42:56PM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> There is a need to update the whole card.
> The user area, the shell and even the card firmware.
> This needs to be handled differently than the
> existing partial updating in the fpga manager.
> 
> Move the write_* ops out of fpga_manager_ops and
> into a new fpga_manager_update_ops struct.  Add
> two update_ops back to fpga_manager_ops,
> partial_update for the exiting functionality and
> full_update for the new functionity.

Partial and Full are somewhat loaded terms with FPGAs -- think partial
reconfiguration vs full reconfiguration.

How about 'persistent' and 'volatile' or something along those lines
instead?

- Moritz
