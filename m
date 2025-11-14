Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7FC35898;
	Fri, 14 Nov 2025 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763113918; cv=none; b=Ct/rp7PYqRqsIw1+ZTXlofHeMjuuGG1OA/S6g9qvUEulc5XhzSbC5ZAOkzvrBXizCDqtpK3TEFiERHbm8sszblptqVCsfiL0nErr6CoAfEsCqxBNGKYpeRBxWQyKnEx0hwfxVm1Y1/snD9/exCbCNMn4Bdq+lHNL0llmyBf1GTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763113918; c=relaxed/simple;
	bh=o1C0X19ijn5qAxn6OTNxbSExkcUdGudqvVuyPNjsYRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYmNxsl9Vp/gYYEpogOavCDYVCuUl0dlGRW5BD4xCNEs1SqPGY5660LmbnO4NnFvy7eY9e08jphKlBA+rh1X6quDMDKbQlR9wVZyJOJWUnRCeVLbj/o7CMlyA0wgFgvyToCfwJ6y2T3ycvkmH943nCBbsMYq77CYXjMVQqRZM2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bq8gdeJl; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bq8gdeJl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763113917; x=1794649917;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o1C0X19ijn5qAxn6OTNxbSExkcUdGudqvVuyPNjsYRo=;
  b=Bq8gdeJlRNYDYMDqzzclI0p+SBIxyRzan333/sNPXETpbwf7kLv0gZdk
   qaiV2DMu/S4ZaE30GDj2N1al56SBqY1e8w+2ccTkRyupXIj57osrFfA1z
   fi4lStHoOpylfh9d2FTUo2b4p0gWOTWrt+lpzxVydc+OvX2+cwIVk4we9
   J3n/VhSqeM0c5y+tnp4/iqm3whB6hOwAD5RKbFmiwZTmwJtxZbrsizLjP
   5S2MR4a+cu0DQvrk8iu8a3/ai1+Axol7caM1fio3tICkrX7w7R1lXsDVS
   AYtyN0nVskx0AnHj+1TU2Q3/FOnWiZQE0zsVD7A2Cawv3qpWa4o6IbH50
   Q==;
X-CSE-ConnectionGUID: nSZeEksBSi+aD1fohnBYwQ==
X-CSE-MsgGUID: 5TfR0ALxTfK4RAl9eLbtCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65303904"
X-IronPort-AV: E=Sophos;i="6.19,304,1754982000"; 
   d="scan'208";a="65303904"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 01:51:56 -0800
X-CSE-ConnectionGUID: Hl2/Ky0sRDm0a3GExQt/qQ==
X-CSE-MsgGUID: 6OIHJbSRSrKXTzecRghEyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,304,1754982000"; 
   d="scan'208";a="227092418"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 14 Nov 2025 01:51:52 -0800
Date: Fri, 14 Nov 2025 17:37:19 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mahesh Rao <mahesh.rao@altera.com>,
	Ho Yin <adrian.ho.yin.ng@altera.com>,
	Niravkumar L Rabara <nirav.rabara@altera.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: agilex5: add fpga-region and fpga-mgr
 nodes
Message-ID: <aRb4T2vEhKlehJiy@yilunxu-OptiPlex-7050>
References: <cover.1763008269.git.khairul.anuar.romli@altera.com>
 <9a4ce6b2470328b9326402a2f00ff285be1793c3.1763008269.git.khairul.anuar.romli@altera.com>
 <aRVyvjCny/I/rElC@yilunxu-OptiPlex-7050>
 <c7470b9e-5c8f-4498-a752-9c986de8aca2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7470b9e-5c8f-4498-a752-9c986de8aca2@kernel.org>

On Thu, Nov 13, 2025 at 08:12:24AM +0100, Krzysztof Kozlowski wrote:
> On 13/11/2025 06:55, Xu Yilun wrote:
> > On Thu, Nov 13, 2025 at 12:43:56PM +0800, Khairul Anuar Romli wrote:
> >> The Intel Agilex 5 SoC contains a programmable FPGA region that requires
> >> proper device tree description to enable FPGA manager support in the Linux
> >> kernel. Without the 'fpga-region' and 'fpga-mgr' nodes, the kernel cannot
> >> detect or manage the FPGA hardware correctly.
> >>
> >> This patch adds a 'fpga-region' node with compatible = "fpga-region", along
> >> with appropriate #address-cells and #size-cells properties, to describe the
> >> FPGA region layout.
> >>
> >> Also defines specific compatible string for Agilex5 and add Agilex string
> >> as fallback for stratix10-soc driver initialization.
> >>
> >> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> > 
> > Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> 
> How this can be reviewed if it is completely wrong and obviously not
> matching the bindings from this patchset?

I apologize. Obviously I didn't pay enough effort on DT. Thanks for
pointing out and providing the Doc.

> 
> Best regards,
> Krzysztof
