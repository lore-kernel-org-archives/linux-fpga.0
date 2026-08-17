Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173E817BED0;
	Mon, 17 Aug 2026 03:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786935979; cv=none; b=sEppUc//YIJ4oulv3rE4dvTiZl5ZI0AeLp3zuFIh+5Tj0bXHx7g4IUvBMoBmkQsBa1QgpdBl+durtK47KNlIz4Ih6rEmio9A8bX5JJObsXDRZMZoYD/Via7SjQEndKR2uJJRbsQ1jJPlRC43PCwP2jSYpBduOpNKjphJ3o958Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786935979; c=relaxed/simple;
	bh=n4txlHJbWEgzbouBG7BAVJCcqrHGoDQFcDBZcQUS2U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfW4zZM6Juk1hDF9+eYVtT7RB8nHMdcil7skUAKDP1AMvyviI0+shQI6yYslY5b4/R3VnnNBLiw+lGBo6YtkJNLNNiGcU/mAXAYFlCOdS3sLurkfbrjFk3Pao0WrGNpeAEWjrxJ2JaYuAA7sGFL9ZQh5NerXo9rXxtONrS0Dcus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=byS4ApTe; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="byS4ApTe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786935977; x=1818471977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n4txlHJbWEgzbouBG7BAVJCcqrHGoDQFcDBZcQUS2U4=;
  b=byS4ApTeDDp/NmRAonoFP4GK0y4p830hpeadnK7cEcg4dKKzf4NEDKe8
   t7Mtu58CpkgjevgZoAXebI0Qntmv31jX5/cxk7E82bLXB4jc91aJHs+MK
   x1+SpJ1hRZSBpohoxRBoNGStxzXBni2c5mjctQmpFyNOvONn2JR5HVv7i
   waF3zfuMKywrYSV2Fnh4O+ja+yzvf1aXDjgUOf0e01Pjaig3DVf8gnGRU
   So3nWO0KJRpT4YS0eJZdOuWJ4em/rclE96kcLw9w0/rqR9OFbtJycA2gq
   9yqbvDtkyxG/HxzQJ2PSA5XplYMEoDUIhFR9Sc5zMY6hiZnjGgwLX9/bA
   A==;
X-CSE-ConnectionGUID: Qt8Jkk87RBetRUaQ2jVARg==
X-CSE-MsgGUID: ZO0x3XvBSGCOeNWwwbTNIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="98769971"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="98769971"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 20:06:16 -0700
X-CSE-ConnectionGUID: xtPhS3N1Q76UsujrfQGZCQ==
X-CSE-MsgGUID: 6jMMzXvLRlehv8EUvRiIzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="269991048"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa005.fm.intel.com with ESMTP; 16 Aug 2026 20:06:14 -0700
Date: Mon, 17 Aug 2026 11:06:13 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marco.pagani@linux.dev>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fpga: region: Add support for FPGA region variants
Message-ID: <aoJ6paA/8ndpJ17y@yilunxu-OptiPlex-7050>
References: <akPZoGCyQW+6+hDX@yilunxu-OptiPlex-7050>
 <5dbd4ac8-a532-4889-bae1-f0bab9a99267@linux.dev>
 <akyyp1GCecWj2Bk2@yilunxu-OptiPlex-7050>
 <417b510f-0f6d-4695-97f5-3fc19b9377b9@linux.dev>
 <amCn8UYdybT+RRnq@yilunxu-OptiPlex-7050>
 <9d4af487-69a7-4a0d-9335-35c3a057de54@linux.dev>
 <anBfAa4LpjbmYHIc@yilunxu-OptiPlex-7050>
 <db7cfe9e-b2ba-4323-bff9-44598e1f70bb@linux.dev>
 <anl8891cH+bUfsGY@yilunxu-OptiPlex-7050>
 <4dbdb52e-1b28-432e-a3a7-ad9c44f17d27@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dbdb52e-1b28-432e-a3a7-ad9c44f17d27@linux.dev>

> > But if the no-verification-in-driver is denied, I think the thing we
> > need to do is to verify the binding between the DT description & image.
> > After we've verified the DTO & the image is a valid pair, they are not
> > arbitrary, whatever the DTO does is necessary to the updated hardware.
> 
> I think we agree on this. Ideally, we should validate the complete
> {config, image} pair. However, I don't see how using DTO at runtime can
> help with this goal.

Validation is not the goal. Re-enumeration is the goal. DTO is what FPGA
is now using for re-enumeration. Validation helps DTO if you want extra
integrity.

> On the contrary, it would put us in a situation
> where neither element of the pair is guaranteed since it enables the
> user to feed arbitrarily forged DTOs.

As you referenced, no OS component (even the kernel) could guarantee the
functionality of the binary for a device, only the device can. So what's
the difference who provides the pair?

The only thing matters here is integrity and authentication, which is
totally a different thing from kernel-user privilege.

I'm also confused you keep on telling that userspace is arbitrary so no
userspace interface, which seems to suggest kenrel should never get any
input from user.
