Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5D340855;
	Thu,  9 Apr 2026 08:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775721809; cv=none; b=OZ47Gq1O7b5wD9nztLnc6Eir9sZhbclJd6A58t9qeOrEZzHPvpAFgwjCfHE2b4vqUm8AXXib9tJCsreUl/K9hrwnEe2I0KaeBV98/CpTmjyTOrIxfK1A7C71AVK8H46NiKvu5SP3jlsgbDVlDsiTGnNDmubovnlqdCPdVJBbtmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775721809; c=relaxed/simple;
	bh=RMzEE8lIvnzzp5KSskqzaUddyFgEFFiCiya37CE2yso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SR+/9xCoHbrQAxs6KQwtlxMFL4Seaum0jM1sOIdsyU0aQHeCaJzRgZD15vVhGOIFIvk6iJqzMAQfXLS+HajQQx2xl08LhNRfunwsIll+pf7JB1T9B06jNGzjVa9rkIoIxQp3C0iI28Xbj8NPNLlcEp3QbeQl7wYPNyF4DWRruPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOCFhyhX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOCFhyhX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB69C4CEF7;
	Thu,  9 Apr 2026 08:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775721809;
	bh=RMzEE8lIvnzzp5KSskqzaUddyFgEFFiCiya37CE2yso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SOCFhyhXU6WwotX+em2FUASsvcA5kNTIGq0udxRmWNvdKSjSmNdQz16F0lwwiPpGk
	 S5aWbCL2sjIp1lxyJphGqVn5+Qk5LmXDBSe+vB8Yih8w9/KHMacf+BiKPtk84vI3qe
	 R0HbymcICmRWPLYmHkjyKuFL5ptAJ0A5qA826fLuQGrNnynajjGX2UMtPvtyB78ZG4
	 MWb04wsGHU+uf3rEYhXI3LvIZK5OJXUd+RCZQAs2xmPoAREW7EnyR/aj7CAtBiErL1
	 T5vNG1CuxdIRslCGqeqtxkV8SwvxSn18MEj0xtaX10aOxL5pnngKpczkdnkLtXp2B3
	 tcq6xj12lyQng==
Date: Thu, 9 Apr 2026 10:03:26 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Phil Pemberton <philpem@philpem.me.uk>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Tom Rix <trix@redhat.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: fpga: Technologic Systems TS-7300
 FPGA Manager
Message-ID: <20260409-versatile-satisfied-mule-d88d24@quoll>
References: <20260408165223.3051759-1-philpem@philpem.me.uk>
 <20260408165223.3051759-2-philpem@philpem.me.uk>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260408165223.3051759-2-philpem@philpem.me.uk>

On Wed, Apr 08, 2026 at 05:52:22PM +0100, Phil Pemberton wrote:
> Add device tree binding documentation for the Altera Cyclone II FPGA
> found on Technologic Systems (now EmbeddedTS) TS-7300 boards, programmed
> via the memory-mapped interface in the CPLD.

Subject - I did not ask to drop "Add". The subject makes little sense now.

With subject fixed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

<form letter>
This is an automated instruction, just in case, because many review
tags are being ignored. If you know the process, just skip it entirely
(please do not feel offended by me posting it here - no bad intentions
intended, no patronizing, I just want to avoid wasted efforts). If you
do not know the process, here is a short explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions of patchset, under or above your Signed-off-by tag, unless
patch changed significantly (e.g. new properties added to the DT
bindings). Tag is "received", when provided in a message replied to you
on the mailing list. Tools like b4 can help here ('b4 trailers -u ...').
However, there's no need to repost patches *only* to add the tags. The
upstream maintainer will do that for tags received on the version they
apply.

https://elixir.bootlin.com/linux/v6.15/source/Documentation/process/submitting-patches.rst#L591
</form letter>

Best regards,
Krzysztof

