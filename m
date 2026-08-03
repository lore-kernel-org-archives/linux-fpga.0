Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A001632D7F8;
	Mon,  3 Aug 2026 03:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785726822; cv=none; b=bKXyDsSlZOmajnrDCqtCw0BQCG975dYNICDrBvTBZecuf9N2orDoRhUOHCwBWuLjH07apozL+RFAK4v+u3ELnsa6n8fEfbFTnKIa0u3jNsPFF6/iNOLvZbpjTGWkkRfXARYd7Omw9Rskk7r/Ztu5mWZdbsy7cSUT48P1a4TB00Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785726822; c=relaxed/simple;
	bh=y4mjoFGlYD2DACCV9EKoBzjnG3ih92Oo2QCzm8XOmF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQNxdUxboAF2JekwC7LyOUabz5QK5/nXTD4wjmVYko9qIfLGBavZBoh39ZxEAMr0CGMCFYHa16oidj2oT9NyMGADuQIZKg7Sd+PNoirHDJh1+JBzYYrM5sXnVrDJnSyU6ToJvoKMKm0DAWHrWZmZ/S7zWA7INYwLk2h/k5GLMRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z+0946Nj; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z+0946Nj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785726820; x=1817262820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y4mjoFGlYD2DACCV9EKoBzjnG3ih92Oo2QCzm8XOmF8=;
  b=Z+0946Nj4RS4dp8oRpMwlUUv0glWpEQd5JsYM9+6CSyOPHJM2XO/nEd6
   +12W0W+vYW8oEkQxchZJDHibnZL/FYK+q1JIpMLWWvjgVitxeU1BqPGyO
   6F8MK6U5FmtmTwSdsTk+P6rZwGkIKFLurpR7Vzu2kmWCzwehgij8vUXOX
   qWcx1g5gmck+Cz2qxUfwC/+MVTt/tKQPjJwiDXuQ0nD5upUkc484isafl
   uKaHWqvgY5Vuq+3TeU5sy2FW3Amx2ZcdQeeRe061Nefzmwm3vR/jxW2YR
   0O0QcvsuwaVepnnMO1kWFBDOgu3XWl8JqZNerSB1MSm6PXyJKKy+gHL8K
   g==;
X-CSE-ConnectionGUID: 66EG0cbyQJmy5+Lol7XwSg==
X-CSE-MsgGUID: xCd6QZD4Rwm9XBF4yj0LqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="73795573"
X-IronPort-AV: E=Sophos;i="6.25,201,1779174000"; 
   d="scan'208";a="73795573"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2026 20:13:40 -0700
X-CSE-ConnectionGUID: PN9UMpqVQPGjPhfPHrJZqQ==
X-CSE-MsgGUID: qGQc9tU9RXuprNSjQUFXFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,201,1779174000"; 
   d="scan'208";a="266197218"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 02 Aug 2026 20:13:39 -0700
Date: Mon, 3 Aug 2026 11:13:38 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Ayananta Paul <ayanantapaul@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH] fpga: dfl: fix spelling in sysfs-platform-dfl-port ABI
 documentation
Message-ID: <anAHYgjrC3+oTF5X@yilunxu-OptiPlex-7050>
References: <20260727152634.5983-1-ayanantapaul@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727152634.5983-1-ayanantapaul@gmail.com>

On Mon, Jul 27, 2026 at 08:56:34PM +0530, Ayananta Paul wrote:
> Correct the spelling of "responding" which was incorrectly written
> as "respoding" in the Document/ABI/testing/sysfs-platform-dfl-port
> ABI testing file.
> 
> Issue identified using:
> `codespell -D - -S "*.bin,*.o,*.a,*.so,*.ko,*.gz,*.png,*.jpg" Documentation/`
> 
> Signed-off-by: Ayananta Paul <ayanantapaul@gmail.com>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next
