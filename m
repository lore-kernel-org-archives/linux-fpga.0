Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCA6511219;
	Fri, 18 Sep 2026 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789753051; cv=none; b=ojYxtc0xIQyjm3FrfjeCJJ6vLEiy2OSz+rzV1UIlNX2cWh7W3mHf7FohT2U6Ht7VHa9AuTUouDzVaPRgeVKaGVw6swWTtoNKUP1ZmjRH8mgVesDkGjQUPcXJZbq8h7w2XybHRUlIZS69RKA5ovMExS8NPV878bhXHvMm0LPfjh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789753051; c=relaxed/simple;
	bh=KTsMvXSvHWAFdaDu3txdxosyPQrR5HRSPmhBlgCHJoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHOPzsu/5c989hewaY2kwL41Vbkl0nFsmrDjkc0bHtPg9tijhkfvyeokyKzLqtCaIdEig+5svc3xeG63dI/OBn92KswwOJuolo8Bxyaz4/QjegkXwSR5v4pmDPnck0VYkLY7CtBgiU1yuGqle8uMrmZeyKRrCosXnlTuJFk3Sws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IBgCXuCh; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IBgCXuCh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789753046; x=1821289046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KTsMvXSvHWAFdaDu3txdxosyPQrR5HRSPmhBlgCHJoI=;
  b=IBgCXuCh5ZXT8Twh9HGSl7RtnjNzuq/c8ewWOHn//9Gyb5Za+DnLz1QQ
   wic9YXZc6JFL9EPFK9WLGETQ1fTrWr38sDXHRjrBx+uIfwKQP/jOeEEL/
   un4OUTGnL07HLG0c6+9cM8dXMayUAfWsTYkN+EAYaT/qp7gy6AndAmuuC
   i4Srx4eCnAf+1OgKZXTlXhpdwjM4T+TU2WtwhCpnAxL0ATASaF/rbdYMx
   cHAn1kvJHuzCzRGbp0z+2VDzBRnd68Vv1yYbcg7NbtQgPmliybRYieLr5
   J9Pi0ilmxYaAgytsPwr4FdWBlqKwNci/d2M6F12AmJIABtZX+E8BMplyu
   Q==;
X-CSE-ConnectionGUID: 1Qjju4AmRAOabVtgrjcl0Q==
X-CSE-MsgGUID: IQ/asi46QCG4qbgyOQ9a3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="775382"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="775382"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 10:37:23 -0700
X-CSE-ConnectionGUID: YacRxtcQRyiTmalkCEpCSg==
X-CSE-MsgGUID: kXSp3H55SqqYoCldmISTBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="271835798"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa008.fm.intel.com with ESMTP; 18 Sep 2026 10:37:18 -0700
Date: Sat, 19 Sep 2026 01:36:51 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marco.pagani@linux.dev>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fpga: region: Add support for FPGA region variants
Message-ID: <aq12s+hUVnnvCKmZ@yilunxu-OptiPlex-7050>
References: <417b510f-0f6d-4695-97f5-3fc19b9377b9@linux.dev>
 <amCn8UYdybT+RRnq@yilunxu-OptiPlex-7050>
 <9d4af487-69a7-4a0d-9335-35c3a057de54@linux.dev>
 <anBfAa4LpjbmYHIc@yilunxu-OptiPlex-7050>
 <db7cfe9e-b2ba-4323-bff9-44598e1f70bb@linux.dev>
 <anl8891cH+bUfsGY@yilunxu-OptiPlex-7050>
 <4dbdb52e-1b28-432e-a3a7-ad9c44f17d27@linux.dev>
 <aoJ6paA/8ndpJ17y@yilunxu-OptiPlex-7050>
 <8848432d-45b0-4efe-adf3-adfb64fe0899@linux.dev>
 <11b1a792-f8b1-4fce-8a7a-8352149febcf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11b1a792-f8b1-4fce-8a7a-8352149febcf@linux.dev>

On Fri, Sep 18, 2026 at 05:07:07PM +0200, Marco Pagani wrote:
> 
> 
> On 17/08/2026 18:14, Marco Pagani wrote:
> > 
> > 
> > On 17/08/2026 05:06, Xu Yilun wrote:
> >>>> But if the no-verification-in-driver is denied, I think the thing we
> >>>> need to do is to verify the binding between the DT description & image.
> >>>> After we've verified the DTO & the image is a valid pair, they are not
> >>>> arbitrary, whatever the DTO does is necessary to the updated hardware.
> >>>
> >>> I think we agree on this. Ideally, we should validate the complete
> >>> {config, image} pair. However, I don't see how using DTO at runtime can
> >>> help with this goal.
> >>
> >> Validation is not the goal. Re-enumeration is the goal. DTO is what FPGA
> >> is now using for re-enumeration. Validation helps DTO if you want extra
> >> integrity.
> > 
> > I would argue that validation is a requirement for any userspace
> > interface, while I do agree that re-enumeration is the goal. In my RFC,
> > re-enumeration is triggered using the DT infrastructure every time
> > userspace switches from one variant to another. Variants can be thought
> > of as pre-validated DT fragments baked into the base DT, rather than
> > DTOs ingested from userspace at runtime.
> > 
> > To clarify my position, going back to a couple of messages ago:
> > 
> > - As I understand it, the current upstream consensus is that hardware
> >   devices must be responsible for verifying their own firmware.
> >   So, the kernel is responsible for protecting the integrity of its
> >   own configuration (live DT), while the reconfiguration engine is
> >   responsible for validating FPGA images;
> > 
> > - If this is not sufficient, and there is a requirement to secure
> >   /lib/firmware, it should be done at the filesystem level using
> >   the IMA subsystem;
> > 
> > - However, since not all FPGA reconfiguration engines support crypto
> >   image verification, and not all SoCs/platforms have a TPM IP or
> >   support for a TEE, we might consider having a subsystem-specific and
> >   optional check for the {config, image} pair as a *future* extension.
> > 
> > 
> >>> On the contrary, it would put us in a situation
> >>> where neither element of the pair is guaranteed since it enables the
> >>> user to feed arbitrarily forged DTOs.
> >>
> >> As you referenced, no OS component (even the kernel) could guarantee the
> >> functionality of the binary for a device, only the device can. So what's
> >> the difference who provides the pair?
> >>
> >> The only thing matters here is integrity and authentication, which is
> >> totally a different thing from kernel-user privilege.
> >>
> >> I'm also confused you keep on telling that userspace is arbitrary so no
> >> userspace interface, which seems to suggest kenrel should never get any
> >> input from user.
> > 
> > My concern isn't about accepting user input in general but rather about
> > the type and scope of that input. I think there is a huge difference in
> > terms of the security between:
> > 
> > - matching a string that userspace sent via sysfs and then applying a
> >   safe configuration already contained in the base DT (validated from
> >   a FIT image).
> > 
> > - having userspace directly pass the kernel DT configuration (as a DTO),
> >   which the kernel must then validate (both syntactically and
> >   semantically) and apply.
> > 
> > In the first scenario, userspace is like a customer selecting from a
> > menu of pre-approved dishes, and then the kitchen safely prepares it.
> > 
> > In the second scenario, userspace is like a customer stepping into the
> > kitchen to cook their own meal, forcing the chef to constantly supervise
> > them to ensure they don't burn the place down.
> > 
> > 
> 
> >>>> It is possible. To be more efficient, I think we should invite
> >>>> boarder discussions.
> 
> > Following up on what you said two messages ago, I think we should invite
> > the DT people and ask for their input to help move this conversation
> > forward.
> 
> Hi Yilun,
> 
> Is it okay with you if I CC the DT people to ask for an opinion?

Of course. It's good to know in which case could a DTO be applied.

But to be clear, I think that only affects how we accept and apply the
image-DTO pair. For now, I basically don't want a varient selection
interface.

> 
> $ scripts/get_maintainer.pl drivers/of
> Rob Herring <robh@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE)
> Saravana Kannan <saravanak@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE)
> devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE)
> linux-kernel@vger.kernel.org (open list)
> 
> 
> Thanks,
> Marco
> 
