Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCA1329C7F
	for <linux-fpga@vger.kernel.org>; Tue,  7 Apr 2026 08:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775548905; cv=none; b=k+CHXQVN9SBTjUx03s5I7YKhIjm7o9HmhVeEVB6JMehokl15u+cfzs9wdUU/7g5WE6iu7rNx84ACsXXESVnIlDcX/6bBPU9oI0+e0TirClw2PP9OHmNyQIs2ZSCo9bCyY8TEahMGDkmn1kPYn03jvkkWQMyq8P/p+oD65X/iI7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775548905; c=relaxed/simple;
	bh=gSoOIZ8z3el8bdagZ7LE2ZyU4ejBx7WPfojJNvfF5jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQwm6aA1oPwFTvDXMbmouItelyfDFJtDUPqNz38GB4VeeiomEGppxpPmhicHXrLJPV/2XeWTw7z7J4oYzfXcSx6d0nGg8Ab7TA6ZSRRsGwwnfEhO52X7ikujtkYZ3Fq+dEs9cbefCKjZvNG5kU/NIC7eOL5UoaVh7mvKo+p4hIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U+Fqikiv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U+Fqikiv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22B3C116C6;
	Tue,  7 Apr 2026 08:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775548905;
	bh=gSoOIZ8z3el8bdagZ7LE2ZyU4ejBx7WPfojJNvfF5jU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U+FqikivOX3/o5zrTpQOF/B9g8QWgUtcYaTV6jaK2EnQUQYsI8jJ2KpxWbfxnmV1o
	 73C5fUfJ3AL2flzITqOSnZxnUoR4c0GwtqloX6xQtiBdmqVXFLXUGIHM+N71OdDA6N
	 J2stPhE0WoL90gMd9B7fMuGEkfExE37Dfagw/wKI=
Date: Tue, 7 Apr 2026 10:01:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: yilun.xu@intel.com, linux-fpga@vger.kernel.org, mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 7.1-rc1
Message-ID: <2026040734-shakiness-outline-5c09@gregkh>
References: <adR1S5wFkU7dOFqH@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adR1S5wFkU7dOFqH@yilunxu-OptiPlex-7050>

On Tue, Apr 07, 2026 at 11:08:59AM +0800, Xu Yilun wrote:
> The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:
> 
>   Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-7.1-rc1

Pulled and pushed out, thanks.

greg k-h
