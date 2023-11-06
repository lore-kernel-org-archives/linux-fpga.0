Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4438C4332F
	for <linux-fpga@archiver.kernel.org>; Mon,  6 Nov 2023 13:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjKFNNL (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Mon, 6 Nov 2023 08:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjKFNNI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 6 Nov 2023 08:13:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACCF10C0
        for <linux-fpga@vger.kernel.org>; Mon,  6 Nov 2023 05:13:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49792C433C7;
        Mon,  6 Nov 2023 13:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276383;
        bh=y9dt7G4tySj6g/iI2v90rUm4gS4hdqAQAl4bNRCWicI=;
        h=Date:From:To:Subject:From;
        b=rcr1ObQeT++71Kz4F1tv1pPf83IV7P+j4Pwxsmld5LkcsZ/fyL0jT6vIXyvJP94HL
         o/EAT0itMpZm9f65rnmJlSNfeej0jxaSIHFAnwM19K1kdx6A0EpSinvhdtmjhZPAfg
         p0belj/vbyiRCAf5J2aSY9kNIf6zm1uWbtYrnYgM=
Date:   Mon, 6 Nov 2023 08:13:02 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     linux-fpga@vger.kernel.org
Subject: PSA: migrating linux-fpga to new vger infrastructure
Message-ID: <20231106-able-bizarre-cassowary-bee7fa@nitro>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Good day!

I plan to migrate the linux-fpga@vger.kernel.org list to the new
infrastructure this week. We're still doing it list-by-list to make sure that
we don't run into scaling issues with the new infra.

The migration will be performed live and should not require any downtime.
There will be no changes to how anyone interacts with the list after
migration is completed, so no action is required on anyone's part.

Please let me know if you have any concerns.

Best wishes,
-K
