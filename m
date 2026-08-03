Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95591335091
	for <linux-fpga@vger.kernel.org>; Mon,  3 Aug 2026 03:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785726767; cv=none; b=W2NN/HS73dPPEY+LQleeJlC+PH2C9nZOOjPQPEbR97TQKev8SPAcx1y4SVoLw6vAoy0rmDPSw4Jj5ohTotCqIf7WjsDbyjjBKi99+gHXdtGdspXJ5oFhYq6eoWbyMTlxnoj/61UDMt9WE/kQmeZpccz+D4bXE7bR0p4DjPpgXxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785726767; c=relaxed/simple;
	bh=4J1jfq4RSl4lHX46nIMM/B4YBBUbsbkQYmTzcwJ5m0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m39sPm0cANnsN4JkFMlZ+V96P6OlwqWt/ZZuEDmV+Njm1aog6PO91NdlJlxfQcijLuBnsjd8Ta+JxGfDE1nzQzn5NrvJQ/T4d3+QB4KGUgtUv6nz+KakyJKKxCI2+/cGXCpk1AB5kUXthFRLfoT1ZcaxaWDwykcC0wI4lL3iNsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fvuyu4t9; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fvuyu4t9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785726766; x=1817262766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4J1jfq4RSl4lHX46nIMM/B4YBBUbsbkQYmTzcwJ5m0E=;
  b=Fvuyu4t93QzN6nrmB8a9hmAz+1MinsACJ/l5C/WOkRC7OjX+qHuI4qs4
   +E6/+1W6WLnGPq4tlp9Ld4duhaVJae6FUw8pngQwgw9crzUMqROKnrpO4
   oAQq0KCLqHNrw4iy2HeUwUOIMVzXfl4+oDo/0vJGalV2n5jAEW0HaY8Te
   +ItJ6D2pnFsoYu8YFImmV146R+Y/eudCyXOoxwSnjoyTQLKEUNHug9K3Q
   X9o4qQc7VgmzDpYOTti+LA1NW9G6y6Twj554T9NmYatBa/ANz9V+atoCH
   uzI4LP/dr0nqfF0BTMXKswDHDk7C8W6XGRHkfaMqLoM6Lz4Ts8sMmEJp/
   A==;
X-CSE-ConnectionGUID: xb7MERgrRammiGJTXucMQw==
X-CSE-MsgGUID: O0VBw+SaQHO6NFHkgmWk+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="86379801"
X-IronPort-AV: E=Sophos;i="6.25,201,1779174000"; 
   d="scan'208";a="86379801"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2026 20:12:44 -0700
X-CSE-ConnectionGUID: f4B7fP24QFCulHVKOZn9Gw==
X-CSE-MsgGUID: fRzBUWrWRki8S5nR89LSfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,201,1779174000"; 
   d="scan'208";a="285728853"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa001.fm.intel.com with ESMTP; 02 Aug 2026 20:12:42 -0700
Date: Mon, 3 Aug 2026 11:12:41 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Daisuke Matsuda <dskmtsd@gmail.com>
Cc: yilun.xu@intel.com, mdf@kernel.org, trix@redhat.com,
	linux-fpga@vger.kernel.org, Daisuke Matsuda <matsuda@preferred.jp>
Subject: Re: [PATCH v2] fpga: altera-cvp: Avoid out-of-bounds read in
 trailing byte write
Message-ID: <anAHKb7kk/77pdTO@yilunxu-OptiPlex-7050>
References: <20260723081912.74082-1-dskmtsd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723081912.74082-1-dskmtsd@gmail.com>

On Thu, Jul 23, 2026 at 08:19:12AM +0000, Daisuke Matsuda wrote:
> From: Daisuke Matsuda <matsuda@preferred.jp>
> 
> The trailing byte path in altera_cvp_send_block() dereferences a u32
> pointer even when only 1-3 bytes remain in the input buffer. If the buffer
> ends at a page or scatterlist boundary, this can read past the valid image
> data and fault.
> 
> Copy the remaining bytes into a zero-initialized u32 before writing the
> final word so only valid bytes are read from the input buffer.
> 
> Fixes: 34d1dc17ce97 ("fpga manager: Add Altera CvP driver")
> Signed-off-by: Daisuke Matsuda <matsuda@preferred.jp>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next
