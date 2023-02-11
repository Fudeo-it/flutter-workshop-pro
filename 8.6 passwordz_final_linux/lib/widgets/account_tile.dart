import 'package:cached_network_image/cached_network_image.dart';
import 'package:favicon/favicon.dart';
import 'package:flutter/material.dart';
import 'package:passwordz/models/account.dart';

class AccountTile extends StatelessWidget {
  final Account account;
  final GestureTapCallback? onTap;
  final bool selected;

  const AccountTile(
    this.account, {
    Key? key,
    this.onTap,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        selected: selected,
        onTap: onTap,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder<Favicon?>(
              future: FaviconFinder.getBest(account.website),
              builder: (context, snapshot) => snapshot.hasData
                  ? CachedNetworkImage(
                      imageUrl: snapshot.data!.url,
                      imageBuilder: (context, imageProvider) => Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16),
                          ),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16),
                        ),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Center(
                        child: Text(
                          account.name[0],
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
            ),
          ],
        ),
        title: Text(account.name),
        subtitle: Text(account.username),
      );
}
