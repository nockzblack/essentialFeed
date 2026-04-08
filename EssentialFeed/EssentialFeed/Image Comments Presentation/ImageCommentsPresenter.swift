//
//  ImageCommentsPresenter.swift
//  EssentialFeed
//
//  Created by Fer Benavides Rodriguez on 08/04/26.
//

import Foundation

public final class ImageCommentsPresenter {
    
    public static var title: String {
        NSLocalizedString(
            "IMAGE_COMMENTS_VIEW_TITLE",
            tableName: "ImageComments",
            bundle: Bundle(for: Self.self),
            comment: "Title for the commemts view")
    }
}
